//
//  MyPostsViewController.swift
//  Best Fishing
//
//  Created by Tom on 2017/10/18.
//  Copyright © 2017年 Deitel and Associates , Inc. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, EditProtocal {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var spicsLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        avatarImageView.layer.masksToBounds = true
        avatarImageView.backgroundColor = UIColor.white
        avatarImageView.layer.borderColor = UIColor.gray.cgColor
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height / 2
        
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraClicked(_ sender: Any) {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            
        })
        
        let pickAction = UIAlertAction(title: "Pick a Photo", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imgPicker = UIImagePickerController()
                imgPicker.delegate = self
                imgPicker.sourceType = .photoLibrary
                imgPicker.allowsEditing = true
                self.present(imgPicker, animated: true, completion: {
                    
                })
            }
        })
        
        let takeAction = UIAlertAction(title: "Take a Photo", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imgPicker = UIImagePickerController()
                imgPicker.delegate = self
                imgPicker.sourceType = .camera
                imgPicker.allowsEditing = false
                self.present(imgPicker, animated: true, completion: {
                    
                })
            }
        })
        
        controller.addAction(pickAction)
        controller.addAction(takeAction)
        controller.addAction(cancelAction)
        self.present(controller, animated: true, completion: {
            
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            avatarImageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: { _ in })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editProfile" {
            let controller = segue.destination as! UINavigationController
            let editController = controller.viewControllers.first as! EditProfileViewController
            editController.delegate = self
        }
    }
    
    func save(specis: String?, age: String?) {
        self.spicsLabel.text = "Favorite Specis: \(specis ?? "")"
        self.spicsLabel.sizeToFit()
        
        self.ageLabel.text = "Age: \(age ?? "")"
        self.ageLabel.sizeToFit()
    }
}
