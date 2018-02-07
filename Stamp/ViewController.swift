//
//  ViewController.swift
//  Stamp
//
//  Created by arisa isshiki on 2018/02/07.
//  Copyright © 2018年 alisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //スタンプ画像の名前が入った配列
    var imageNameArray: [String] = ["kappa1.png", "kappa3.png", "kappa2.png", "kappa4.png"]
    
    //選択しているスタンプ画像の番号
    var imageIndex: Int = 0
    
    //背景画像を表示させるImageView
    @IBOutlet var haikeiImageView: UIImageView!
    
    //スタンプ画像が入るImageView
    var ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //タッチされた位置を取得
        let touch:UITouch = touches.first!
        let location: CGPoint = touch.location(in: self.view)
        
        //もし,imageIndexが0でない　（押すスタンプが選ばれていない）とき
        if imageIndex != 0 {
            //スタンプサイズを40pxの正方形に指定
            ImageView = UIImageView(frame: CGRect(x: 0, y:0, width: 70, height: 70))
            
            //押されたスタンプの画像を指定
            let image: UIImage = UIImage(named: imageNameArray[imageIndex - 1])!
            ImageView.image = image
            
            //タッチされた位置に画像を置く
            ImageView.center = CGPoint(x: location.x ,y : location.y)
            
            //画像を表示する
            self.view.addSubview(ImageView)
            
        }
    }
    
    
    @IBAction func selectedFirst() {
        imageIndex = 1
    }
    
    @IBAction func selectedSecond() {
        imageIndex = 2
    }
    
    @IBAction func selectedThird() {
        imageIndex = 3
    }
    
    @IBAction func selectedFourth() {
        imageIndex = 4
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back() {
        
        self.ImageView.removeFromSuperview()
    }
    
    @IBAction func selectedBackground() {
        //UIImagePickerControllerのインスタンスを作る
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        
        //フォトライブラリを使う設定をする
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        //フォトライブラリを呼び出す
        self.present(imagePickerController, animated: true, completion: nil)
        
        //フォトライブラリから画像の選択が終わったら呼ばれるメソッド
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String : Any]) {
            
            // imageに選んだ画像を設定する
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            
            // imageを背景に設定する
            haikeiImageView.image = image
            
            //フォトライブラリを閉じる
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func save() {
        //画面上のスクリーンショットを取得
        let rect:CGRect = CGRect(x: 0, y: 30, width: 320, height: 380)
        UIGraphicsBeginImageContext(rect.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //フォトライブラリに保存
        UIImageWriteToSavedPhotosAlbum(capture!,nil, nil, nil)
    
    
    }
}
