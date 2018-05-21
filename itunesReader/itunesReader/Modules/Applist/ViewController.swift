//
//  ViewController.swift
//  itunesReader
//
//  Created by Shyam Parmar on 06/05/18.
//  Copyright © 2018 FreeWare. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
  let cellId = "AppTableCell"
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
      // call method after 30 nenoseconds time
      self.startDownloadingImage()
    }
  }
  
  func showError(_ title: String,_ message: String) {
    var alert = AppAlert.Alert(title, message)
    alert = AppAlert.addCancelButton(alert, "Ok")
    alert = AppAlert.addOtherButton(alert, "Retry",requestData)
    self.present(alert, animated: true, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
// class extension
extension ViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberofRows()
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                             for: indexPath) as! AppTableViewCell
    cell.appTitle.text = viewModel.appName(for: indexPath)
    cell.loadingIndicator.startAnimating()
    cell.appImage.image = nil
    cell.layoutMargins = UIEdgeInsets.zero
    cell.appDescription.text = viewModel.appDescription(for: indexPath)
    
    if let imageData = viewModel.appImage(for: indexPath) {
     cell.setImage(imageData)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
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
  
  func startDownloadingImage() {
    if let pathsArray = appListTable.indexPathsForVisibleRows {
      for indexPath in pathsArray {
        viewModel.requestImage(for: indexPath, reloadTableCells(_:))
      }
    }
  }
}
