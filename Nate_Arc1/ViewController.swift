//
//  ViewController.swift
//  Nate_Arc1
//
//  Created by Larry Mcdowell on 9/7/19.
//  Copyright © 2019 Larry Mcdowell. All rights reserved.
//

import UIKit
import ArcGIS

class ViewController: UIViewController {


    @IBOutlet weak var mapView: AGSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupMap()
        setupButtons()
        
    }


    private func setupMap(){
        mapView.map = AGSMap(basemapType: .navigationVector, latitude: 34.848741, longitude: -82.219049, levelOfDetail: 13)
        
      //  let mycenter = AGSPoint(clLocationCoordinate2D: CLLocationCoordinate2DMake(34.848741, -82.219048))
        
        let envelope = AGSEnvelope(xMin: -124.83145667, yMin: 30.49849464, xMax: -113.91375495, yMax: 44.69150688, spatialReference: mapView.spatialReference)
        
      //  mapView.setViewpointCenter(mycenter, completion: {(complete) in print("Hi")})
       //let url = URL(string:"https://services6.arcgis.com/ssFJjBXIUyZDrSYZ/arcgis/rest/services/Class_Airspace/FeatureServer/0")
       // let url = URL(string:"https://services6.arcgis.com/ssFJjBXIUyZDrSYZ/arcgis/rest/services/Runways/FeatureServer/0/query?outFields=*&where=1%3D1")
        let url = URL(string:"https://services6.arcgis.com/ssFJjBXIUyZDrSYZ/arcgis/rest/services/Special_Use_Airspace/FeatureServer/0")
        let faatable = AGSServiceFeatureTable(url: url!)
        
        let layer = AGSFeatureLayer(featureTable: faatable)
        
        mapView.map?.operationalLayers.add(layer)
        
    }
    
    
    func setupButtons(){
        let sB = UIButton()
        sB.setTitle("Zoom IN", for: .normal)
        sB.backgroundColor = .green
        sB.titleLabel?.textColor = .white
        sB.layer.cornerRadius = 10
        sB.layer.borderWidth = 2
        sB.layer.borderColor = UIColor.black.cgColor
        sB.addTarget(self, action: #selector(changeIt), for: .touchUpInside)
        //sB.frame = CGRect(x: 20, y: 20, width: 200, height: 200)
        self.mapView.addSubview(sB)
        sB.translatesAutoresizingMaskIntoConstraints = false
        sB.topAnchor.constraint(equalTo: mapView.topAnchor).isActive = true
        sB.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sB.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //sB.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 200).isActive = true
        sB.centerXAnchor.constraint(equalTo: mapView.centerXAnchor, constant: 0).isActive = true
        
        let sBO = UIButton()
        sBO.setTitle("Zoom Out", for: .normal)
        sBO.backgroundColor = .red
        sBO.titleLabel?.textColor = .white
        sBO.layer.cornerRadius = 10
        sBO.layer.borderWidth = 2
        sBO.layer.borderColor = UIColor.black.cgColor
        sBO.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
        //sB.frame = CGRect(x: 20, y: 20, width: 200, height: 200)
        self.mapView.addSubview(sBO)
        sBO.translatesAutoresizingMaskIntoConstraints = false
        sBO.topAnchor.constraint(equalTo: mapView.topAnchor).isActive = true
        sBO.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sBO.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sBO.leadingAnchor.constraint(equalTo: sB.trailingAnchor, constant: 10).isActive = true
        // sBO.centerXAnchor.constraint(equalTo: mapView.centerXAnchor, constant: 0).isActive = true
    }
    
    @objc func changeIt(sender:UIButton){
        let currentScale = self.mapView.mapScale
        let targetScale = currentScale / 5 //zoom in
        let currentCenter = self.mapView.visibleArea!.extent.center
        self.mapView.setViewpoint(AGSViewpoint(center: currentCenter, scale: targetScale), duration: 2, curve: AGSAnimationCurve.easeInOutSine) { (finishedWithoutInterruption) in
            //            if finishedWithoutInterruption {
            //                self.mapView.setViewpoint(AGSViewpoint(center: currentCenter, scale: currentScale), duration: 2, curve: .easeInOutSine)
            //            }
        }
    }
    @objc func zoomOut(sender:UIButton){
        let currentScale = self.mapView.mapScale
        let targetScale = currentScale * 5 //zoom in
        let currentCenter = self.mapView.visibleArea!.extent.center
        self.mapView.setViewpoint(AGSViewpoint(center: currentCenter, scale: targetScale), duration: 2, curve: AGSAnimationCurve.easeInOutSine) { (finishedWithoutInterruption) in
            //            if finishedWithoutInterruption {
            //                self.mapView.setViewpoint(AGSViewpoint(center: currentCenter, scale: currentScale), duration: 2, curve: .easeInOutSine)
            //            }
        }
    }
}

