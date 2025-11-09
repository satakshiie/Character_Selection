//
//  ViewController.swift
//  BallGameDemo
//
//  Created by Ekansh Jindal on 07/11/25.
//

import UIKit
import RealityKit
import Combine

enum Lane: Int, CaseIterable {
    case left = -1
    case center = 0
    case right = 1
    
    var xPosition: Float {
        let laneWidth: Float = 1.0
        return Float(self.rawValue) * laneWidth
    }
}

class GameViewController: UIViewController {

    @IBOutlet weak var arView: ARView!
    var ballEntity: ModelEntity!
    var currentLane: Lane = .center
    let laneChangeDuration: TimeInterval = 0.15
    var isRunning: Bool = false
    let runSpeed: Float = 3.0
    var trackPieces: [ModelEntity] = []
    let trackLength: Float = 20.0
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView.cameraMode = .nonAR

        let camera = PerspectiveCamera()
        let cameraAnchor = AnchorEntity(world: .zero)
        cameraAnchor.addChild(camera)
        camera.position = [0, 1.5, 4]
        arView.scene.addAnchor(cameraAnchor)
        setupTrack()
        let ballMesh = MeshResource.generateSphere(radius: 0.5)
        var ballMaterial = SimpleMaterial(color: .blue, isMetallic: false)
        ballMaterial.roughness = 1.0
        ballEntity = ModelEntity(mesh: ballMesh, materials: [ballMaterial])
        ballEntity.position = [currentLane.xPosition, 0.5, 0]
        let ballAnchor = AnchorEntity(world: .zero)
        ballAnchor.addChild(ballEntity)
        arView.scene.addAnchor(ballAnchor)
//        print("✅ Game scene setup complete!")
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        arView.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        arView.addGestureRecognizer(swipeRight)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeUp.direction = .up
        arView.addGestureRecognizer(swipeUp)
        arView.scene.subscribe(to: SceneEvents.Update.self) { [weak self] event in
            self?.gameLoop(deltaTime: event.deltaTime)
        }
        .store(in: &cancellables)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func setupTrack() {
        let laneWidth: Float = 1.0
        let trackHeight: Float = 0.1
        let laneColor = UnlitMaterial(color: .white)
        let dividerColor = UnlitMaterial(color: .gray)
        for segmentIndex in 0...1 {
            let segmentOffsetZ = -(Float(segmentIndex) * self.trackLength)
            for i in 0..<3 {
                let xPos = Float(i - 1) * laneWidth
                let laneMesh = MeshResource.generateBox(width: laneWidth, height: trackHeight, depth: self.trackLength)
                let laneEntity = ModelEntity(mesh: laneMesh, materials: [laneColor])
                laneEntity.position = [xPos, 0, -(self.trackLength / 2) + segmentOffsetZ]
                let laneAnchor = AnchorEntity(world: .zero)
                laneAnchor.addChild(laneEntity)
                arView.scene.addAnchor(laneAnchor)
                self.trackPieces.append(laneEntity)
            }
            let dividerMesh = MeshResource.generateBox(width: 0.1, height: trackHeight + 0.01, depth: self.trackLength)
            let leftDividerEntity = ModelEntity(mesh: dividerMesh, materials: [dividerColor])
            leftDividerEntity.position = [-laneWidth / 2, 0, -(self.trackLength / 2) + segmentOffsetZ]
            let leftDividerAnchor = AnchorEntity(world: .zero)
            leftDividerAnchor.addChild(leftDividerEntity)
            arView.scene.addAnchor(leftDividerAnchor)
            self.trackPieces.append(leftDividerEntity)
            let rightDividerEntity = ModelEntity(mesh: dividerMesh, materials: [dividerColor])
            rightDividerEntity.position = [laneWidth / 2, 0, -(self.trackLength / 2) + segmentOffsetZ]
            let rightDividerAnchor = AnchorEntity(world: .zero)
            rightDividerAnchor.addChild(rightDividerEntity)
            arView.scene.addAnchor(rightDividerAnchor)
            self.trackPieces.append(rightDividerEntity)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isRunning = true
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isRunning = false
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isRunning = false
    }
    func gameLoop(deltaTime: TimeInterval) {
        guard self.isRunning else { return }
        let distance = runSpeed * Float(deltaTime)
        let totalTrackLength = self.trackLength * 2
        for piece in self.trackPieces {
            piece.position.z += distance
            if piece.position.z > (self.trackLength / 2) {
                piece.position.z -= totalTrackLength
            }
        }
    }
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        guard self.ballEntity != nil else { return }

        switch sender.direction {
        case .left:
            changeLane(direction: .left)
        case .right:
            changeLane(direction: .right)
        case .up:
            jump()
        default:
            break
        }
    }
    func changeLane(direction: UISwipeGestureRecognizer.Direction) {
        var targetLane: Lane = currentLane
        
        if direction == .left && currentLane.rawValue > Lane.left.rawValue {
            targetLane = Lane(rawValue: currentLane.rawValue - 1)!
        } else if direction == .right && currentLane.rawValue < Lane.right.rawValue {
            targetLane = Lane(rawValue: currentLane.rawValue + 1)!
        } else {
            return
        }
        currentLane = targetLane
        
        var targetTransform = ballEntity.transform
        targetTransform.translation.x = currentLane.xPosition
        
        ballEntity.move(to: targetTransform, relativeTo: nil, duration: laneChangeDuration, timingFunction: .easeInOut)
    }
    func jump() {
        let currentPosition = ballEntity.position
        let jumpHeight: Float = 1.0
        
        var jumpUpTransform = ballEntity.transform
        jumpUpTransform.translation.y += jumpHeight
        
        var jumpDownTransform = ballEntity.transform
        jumpDownTransform.translation.y = currentPosition.y
        
        let jumpUpAnimation = ballEntity.move(to: jumpUpTransform, relativeTo: nil, duration: 0.2, timingFunction: .easeOut)
        
        arView.scene.publisher(for: AnimationEvents.PlaybackCompleted.self)
            .filter { $0.playbackController == jumpUpAnimation }
            .first()
            .sink { [weak self] _ in
                self?.ballEntity.move(to: jumpDownTransform, relativeTo: nil, duration: 0.2, timingFunction: .easeIn)
            }
            .store(in: &cancellables)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
