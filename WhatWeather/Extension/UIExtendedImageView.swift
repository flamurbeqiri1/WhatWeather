//
//  UIExtendedImageView.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 27/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import UIKit

@IBDesignable open class UIExtendedImageView: UIImageView {

    // MARK: - Inspectable attributes

    /**
     When positive, the background of the layer will be drawn with
     rounded corners. Also effects the mask generated by the
     `masksToBounds' property. Defaults to zero. Animatable.

     (equivalent to layer.cornerRadius)
     */
    @IBInspectable open var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = max(0.0, min(newValue, min(bounds.width, bounds.height) / 2.0))
        }
    }

    /**
     The width of the layer's border, inset from the layer bounds. The
     border is composited above the layer's content and sublayers and
     includes the effects of the `cornerRadius' property. Defaults to
     zero. Animatable.

     (equivalent to layer.borderWidth)
     */
    @IBInspectable open var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    /**
     The color of the layer's border. Defaults to opaque black. Colors
     created from tiled patterns are supported. Animatable.

     (equivalent to layer.borderColor)
     */
    @IBInspectable open var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set { layer.borderColor = newValue?.cgColor }
    }

    // MARK: - Initializers

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Decode attributes
        cornerRadius = aDecoder.decodeObject(forKey: EncodingKey.cornerRadius.rawValue) as? CGFloat ?? cornerRadius
        borderWidth = aDecoder.decodeObject(forKey: EncodingKey.borderWidth.rawValue) as? CGFloat ?? borderWidth
        borderColor = aDecoder.decodeObject(forKey: EncodingKey.borderColor.rawValue) as? UIColor
    }

    // MARK: - Layout updates

    override open func layoutSubviews() {
        super.layoutSubviews()

        // Recompute cornerRadius from bounds
        cornerRadius = max(0.0, min(cornerRadius, min(bounds.width, bounds.height) / 2.0))
    }

}

// MARK: - NSCoding

extension UIExtendedImageView/*: NSCoding*/ {

    fileprivate enum EncodingKey: String {
        case cornerRadius
        case borderWidth
        case borderColor
    }

    open override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(cornerRadius, forKey: EncodingKey.cornerRadius.rawValue)
        aCoder.encode(borderWidth, forKey: EncodingKey.borderWidth.rawValue)
        aCoder.encode(borderColor, forKey: EncodingKey.borderColor.rawValue)
    }

}

// MARK: Deprecated calls

extension UIExtendedImageView {

    /**
     The color of the shadow. Defaults to opaque black. Colors created
     from patterns are currently NOT supported. Animatable.

     (equivalent to layer.shadowColor)
     */
    @available(*, unavailable, message: "shadowColor is not supported on UIExtendedImageView, embed it in a shadowed UIExtendedView instead. Will be removed in further versions")
    @IBInspectable open var shadowColor: UIColor? {
        get { assert(false, "shadowColor is not supported on UIExtendedImageView, embed it in a shadowed UIExtendedView instead."); return nil }
        set { assert(false, "shadowColor is not supported on UIExtendedImageView, embed it in a shadowed UIExtendedView instead.") }
    }

    /**
     The opacity of the shadow. Defaults to 0. Specifying a value outside the
     [0,1] range will give undefined results. Animatable.

     (equivalent to layer.shadowOpacity)
     */
    @available(*, unavailable, message: "shadowOpacity is not supported on UIExtendedImageView, embed it in a shadowed UIExtendedView instead. Will be removed in further versions")
    @IBInspectable open var shadowOpacity: Float {
        get { assert(false, "shadowOpacity is not supported on UIExtendedImageView, embed it in a shadowed UIExtendedView instead."); return 0.0 }
        set { assert(false, "shadowOpacity is not supported on UIExtendedImageView, embed it in a shadowed UIExtendedView instead.") }
    }

    /**
     The shadow offset. Defaults to (0, -3). Animatable.

     (equivalent to layer.shadowOffset)
     */
    @available(*, unavailable, message: "shadowOffset is not supported on UIExtendedImageView, embed it in a shadowed UIExtendedView instead. Will be removed in further versions")
    @IBInspectable open var shadowOffset: CGSize {
        get { assert(false, "shadowOffset is not supported on UIExtendedImageView, embed it in a shadowed UIExtendedView instead."); return CGSize.zero }
        set { assert(false, "shadowOffset is not supported on UIExtendedImageView, embed it in a shadowed UIExtendedView instead.") }
    }

    /**
     The blur radius used to create the shadow. Defaults to 3. Animatable.

     (equivalent to layer.shadowRadius)
     */
    @available(*, unavailable, message: "shadowRadius is not supported on UIExtendedImageView, embed it in a shadowed UIExtendedView instead. Will be removed in further versions")
    @IBInspectable open var shadowRadius: CGFloat {
        get { assert(false, "shadowRadius is not supported on UIExtendedImageView, embed it in a shadowed UIExtendedView instead."); return 0.0 }
        set { assert(false, "shadowRadius is not supported on UIExtendedImageView, embed it in a shadowed UIExtendedView instead.") }
    }

}