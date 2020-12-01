# SVG-to-UIBezierPath
Generates UIBezierPath object from a SVG data string (Swift 5).

Usage example:

```swift

let data = "M150.397632,0.69786 L111.360007,104.814896 L0.2824819,109.561155 L87.2094582,178.833944 L57.3893765,285.974287 L150.150422,224.705538 L242.826065,286.135474 L238.873007,271.891687 L213.2012,178.99012 L300.282482,109.850123 L189.217267,104.874402 L150.397632,0.69786 Z M150.334994,32.2849522 L181.414722,115.594616 L270.306637,119.567718 L200.617956,174.863556 L224.293899,260.603349 L150.153554,211.451424 L75.9207031,260.474107 L99.824251,174.786094 L30.2274274,119.327816 L119.113288,115.523 L150.334994,32.2849522 Z"

func shapeLayerFromSVG(rect: CGRect) -> CAShapeLayer {
    let bezier = UIBezierPath.generateBezierFromSVG(string: data)
    
    let shape = CAShapeLayer()
    shape.strokeColor = UIColor.black.cgColor
    shape.fillColor = UIColor.clear.cgColor
    shape.bounds = rect
    shape.position = rect.center
    
    bezier.center(inRect: rect)
    shape.path = bezier.cgPath
    
    return shape
}

override func viewDidLoad() {
    super.viewDidLoad()
    let shape = shapeLayerFromSVG(rect: view.frame)
    view.layer.addSublayer(shape)
}
```

Known issue:
* incomplete implementation, currently implemented methods: `UIBezierPath.move(to:)`, `UIBezierPath.addCurve(to:, controlPoint1:, controlPoint2:)`, `UIBezierPath.addLine(to:)`, `UIBezierPath.close()`
* the parser only reads the `<path d=""></path>` value, not the entire SVG file
* there might be errors in parsing different SVG formats, I tested the generated code from Sketch and it works ok. As a workaround you can import the SVG in Sketch App and then export code from there.




