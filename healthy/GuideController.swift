//
//  GuideController.swift
//  healthy
//
//  Created by BanDouMacmini-1 on 16/9/19.
//  Copyright © 2016年 WHY. All rights reserved.
//

import UIKit

class GuideController: BaseController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let colors: [(r:CGFloat, g:CGFloat, b:CGFloat)] = [
                                                    (r: 1.0, g: 0.53, b: 0.0),
                                                    (r: 0.4, g: 0.6, b: 0.0),
                                                    (r: 0.0, g: 0.6, b: 0.8)
                                                ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.backgroundColor = UIColor(red: self.colors[0].r, green: self.colors[0].g, blue: self.colors[0].b, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.backgroundColor = colorWithOffset(offset: scrollView.contentOffset.x)
    }
    
    func colorWithOffset(offset: CGFloat) -> UIColor {
        let pageNumber = Int(round(self.scrollView.contentOffset.x / self.scrollView.frame.size.width))
        self.pageControl.currentPage = pageNumber
        
        if pageNumber < 0 {
            return UIColor(red: self.colors[0].r, green: self.colors[0].g, blue: self.colors[0].b, alpha: 1.0)
        } else if pageNumber >= 2 {
            return UIColor(red: self.colors[2].r, green: self.colors[2].g, blue: self.colors[2].b, alpha: 1.0)
        } else {
            
            let color1 = self.colors[pageNumber]
            let color2 = self.colors[pageNumber+1]
            
            var red: CGFloat = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat = 0.0
            
            let scale = offset / (self.view.frame.width * (CGFloat(pageNumber) + 1))
            red = color1.r + scale * (color2.r - color1.r)
            green = color1.g + scale * (color2.g - color1.g)
            blue = color1.b + scale * (color2.b - color1.b)
            
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
        
    }
}
