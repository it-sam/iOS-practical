//
//  ViewController.swift
//  itunesReader
//
//  Created by Shyam Parmar on 06/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
  let viewModel = AppListViewModel()
  @IBOutlet weak var appListTable: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    appListTable.layoutMargins = .zero
    appListTable.separatorInset = .zero
    self.title = "App List"
    self.requestData()
  }
    
  func requestData() {
    // use of closures
    viewModel.requestData(success: reloadTable,
                          failure: showError(_:_:))
  }
    
  func reloadTable() {
    // DispatchQueue async use
    DispatchQueue.main.async {
      // Get the main queue
      self.appListTable.reloadData()
    }
    DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 30)) {
      // call method after 30 nanoseconds time
      self.startDownloadingImage()
    }
  }
  
  func showError(_ title: String,_ message: String) {
    DispatchQueue.main.async {
        var alert = AppAlert.Alert(title, message)
        alert = AppAlert.addCancelButton(alert, "Ok")
        alert = AppAlert.addOtherButton(alert, "Retry",self.requestData)
        self.present(alert, animated: true, completion: nil)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
// tabview data source and delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows()
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let model = self.viewModel.cellViewModel(for: indexPath) else {
        return UITableViewCell ()
    }
    let cell = tableView.dequeueReusableCell(withIdentifier: AppTableViewCell.identifier,
                                             for: indexPath) as! AppTableViewCell
    
    cell.layoutMargins = UIEdgeInsets.zero
    cell.updateWithModel(model: model)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}
// Scrollview delegate
extension ViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      viewModel.suspendOperatios()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      self.startDownloadingImage()
    }
    // lazy loading of images using Operation
    func reloadTableCells(_ indexPaths: [IndexPath]) {
      // DispatchQueue  async use
      DispatchQueue.main.async {
        self.appListTable.reloadRows(at:indexPaths,
                                     with: .none)
      }
    }
}
 // Internal functions
extension ViewController {
    private func startDownloadingImage() {
      if let pathsArray = appListTable.indexPathsForVisibleRows {
        for indexPath in pathsArray {
          viewModel.requestImage(for: indexPath, reloadTableCells(_:))
        }
      }
    }
}
