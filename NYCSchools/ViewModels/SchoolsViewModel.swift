//
//  SchoolsViewModel.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 26.01.2023.
//

import Foundation
import CoreLocation
import UIKit

final class SchoolsViewModel: NSObject {
    
    weak var tableView: UITableView? = nil
    
    weak var delegate: SchoolsViewModelDelegate? = nil
    
    var schools: [School] = [] {
        didSet {
            delegate?.didUpdate(schools: schools)
        }
    }
    
    var offset: UInt = 0
    
    var isLoadingSchools = false {
        didSet {
            if isLoadingSchools {
                tableView?.refreshControl?.beginRefreshing()
            } else {
                tableView?.refreshControl?.endRefreshing()
            }
        }
    }
    
    init(_ tableView: UITableView?) {
        super.init()
        
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(UINib(nibName: SchoolTableViewCell.reuseIdentifier, bundle: nil),
                                 forCellReuseIdentifier: SchoolTableViewCell.reuseIdentifier)
        self.tableView?.refreshControl = UIRefreshControl()
        self.tableView?.refreshControl?.addTarget(self,
                                                  action: #selector(resetSearchResults),
                                                  for: .valueChanged)
        self.tableView?.separatorStyle = .none
    }
    
    @objc func loadSchools() {
        isLoadingSchools = true
        
        OpenDataService().schools(offset: offset,
                                  completion: { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let schools):
                let newCount = self.schools.count + schools.count
                var indexPaths = [IndexPath]()
                for row in self.schools.count..<newCount {
                    let indexPath = IndexPath(row: row, section: 0)
                    indexPaths.append(indexPath)
                }
                
                self.schools += schools
                self.tableView?.beginUpdates()
                self.tableView?.insertRows(at: indexPaths, with: .fade)
                self.tableView?.endUpdates()
                self.offset += UInt(schools.count)
            case .failure(let error):
                self.delegate?.didFail(with: error)
            }
            
            self.isLoadingSchools = false
        })
    }
    
    @objc func resetSearchResults() {
        schools = []
        offset = 0
        tableView?.reloadData()
        loadSchools()
    }
    
    func updateStyle(for traitCollection: UITraitCollection) {
        // Whenever user interface style changes - reload rows to update style of the map snapshot.
        // Given more time I would improve the process of cells reloading depending on the currently
        // used style.
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDelegate methods

extension SchoolsViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard schools.indices.contains(indexPath.row) else {
            return
        }
        
        delegate?.didSelect(school: schools[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = schools.count - 2
        if !isLoadingSchools && indexPath.row == lastElement {
            loadSchools()
        }
    }
}

// MARK: - UITableViewDataSource methods

extension SchoolsViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SchoolTableViewCell
        
        let school = schools[indexPath.row]
        
        cell.schoolLocationImageView.snapshotMap(for: school)
        
        cell.schoolNameLabel.attributedText = attributedString(with: UIImage(systemName: "graduationcap.fill")!.withTintColor(.white),
                                                               imageBounds: CGRect(x: 0.0, y: -1.5, width: 14.0, height: 12.0),
                                                               text: school.name ?? "N/A")
        
        cell.schoolAddressLabel.attributedText = attributedString(with: UIImage(systemName: "building.2.fill")!.withTintColor(.white),
                                                                  imageBounds: CGRect(x: 0.0, y: -1.0, width: 12.0, height: 12.0),
                                                                  text: school.address ?? "N/A")
        
        cell.schoolEmailLabel.attributedText = attributedString(with: UIImage(systemName: "envelope.fill")!.withTintColor(.white),
                                                                imageBounds: CGRect(x: 0.0, y: -1.0, width: 16.0, height: 11.0),
                                                                text: school.email ?? "N/A")
        
        cell.schoolWebsiteLabel.attributedText = attributedString(with: UIImage(systemName: "paperplane.fill")!.withTintColor(.white),
                                                                  imageBounds: CGRect(x: 0.0, y: -1.0, width: 12.0, height: 12.0),
                                                                  text: school.website?.absoluteString ?? "N/A")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        schools.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110.0
    }
    
    func attributedString(with image: UIImage,
                          imageBounds: CGRect,
                          text: String) -> NSAttributedString {
        let imageAttachment = NSTextAttachment(image: image)
        imageAttachment.bounds = imageBounds
        let imageString = NSAttributedString(attachment: imageAttachment)
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(imageString)
        attributedString.append(NSAttributedString(string: " " + text))
        
        return attributedString
    }
}
