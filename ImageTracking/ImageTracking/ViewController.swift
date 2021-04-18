//
//  ViewController.swift
//  ImageTracking
//
//  Created by Xavier Aguas on 4/15/21.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    private var planeNode: SCNNode?
    private var imageNode: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        //sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Load reference images from "AR Resources folder"
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "Photos", bundle: Bundle.main) else {print("No images available")
            return
        }

        
        configuration.detectionImages = referenceImages
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    

    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return
        }
    // 1. Load plane's scene
        let planeScene = SCNScene(named: "art.scnassets/plane.scn")!
        let planeNode = planeScene.rootNode.childNode(withName: "plane", recursively: true)!
                
        
    // 2. Calculate size based on planeNode's bounding box.
        let (min, max) = planeNode.boundingBox
        let size = SCNVector3Make(max.x - min.x, max.y - min.y, max.z - min.z)
        
    // 3. Calculate the ratio of difference between real image and object size.
       // Ignore Y axis because it will be pointed out of the image.
       let widthRatio = Float(imageAnchor.referenceImage.physicalSize.width)/size.x
       let heightRatio = Float(imageAnchor.referenceImage.physicalSize.height)/size.z
       // Pick smallest value to be sure that object fits into the image.
       let finalRatio = [widthRatio, heightRatio].min()!

    // 4. Set transform from imageAnchor data.
        planeNode.transform = SCNMatrix4(imageAnchor.transform)
    
    // 5. Animate appearance by scaling model from 0 to previously calculated value.
    let appearanceAction = SCNAction.scale(to: CGFloat(finalRatio), duration: 0.4)
    appearanceAction.timingMode = .easeOut
    // Set initial scale to 0.
    planeNode.scale = SCNVector3Make(0, 0, 0)
    // Add to root node.
    sceneView.scene.rootNode.addChildNode(planeNode)
    // Run the appearance animation.
    planeNode.runAction(appearanceAction)
    
    self.planeNode = planeNode
    self.imageNode = node
        
        
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
