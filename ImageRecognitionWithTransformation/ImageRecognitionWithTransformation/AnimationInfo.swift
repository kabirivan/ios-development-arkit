//
//  AnimationInfo.swift
//  ImageRecognitionWithTransformation
//
//  Created by Xavier Aguas on 4/18/21.
//

import Foundation
import SceneKit

struct AnimationInfo {
    var startTime: TimeInterval
    var duration: TimeInterval
    var initialModelPosition: simd_float3
    var finalModelPosition: simd_float3
    var initialModelOrientation: simd_quatf
    var finalModelOrientation: simd_quatf
}
