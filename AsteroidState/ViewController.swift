//
//  ViewController.swift
//  AsteroidState
//
//  Created by Sanjay Thakkar on 06/02/23.
//

import UIKit

class ViewController: UIViewController {

    //MARK: -  Outlets
    @IBOutlet var btnFrom: UIButton!
    @IBOutlet var btnTo: UIButton!
    @IBOutlet var tblData: UITableView!
    {
        didSet{
            tblData.tableFooterView = UIView()
        }
    }
    @IBOutlet var chart: AWLineChart! {
        didSet{
                    chart.gridWidth = 0.3
                    chart.lineWidth = 3
                    chart.sideSpace = 44
                    chart.bottomSpace = 44
                    chart.showVerticalGrid = true
                    chart.showHorizontalGrid = true
                    chart.showBottomLabels = true
                    chart.showSideLabels = true
                    chart.gridColor = .gray
                    chart.labelsColor = .black
                    chart.animationDuration = 0.3
                    chart.chartType = .curved
                    chart.tintColor = .orange
                    chart.dataSource = self
        }
    }
    let vm = AstroidsVM()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: -  UI Elements
    func setupUI() {
        
    }


    //MARK: -  Button Actions
    
    @IBAction func tappedOnFrom(_ sender: Any) {
        self.openDatePicker(sender: sender as! UIView) { selectedDate in
            self.vm.fromDate = selectedDate
            if let date = selectedDate {
                self.btnFrom.setTitle(date.string(), for: .normal)
                self.btnTo.setTitle("To Date", for: .normal)
                self.vm.toDate = nil
            }
        }
    }
    
    @IBAction func tappedOnTo(_ sender: Any) {
        
        let calendar = Calendar.current
        var maxDate:Date?
        if let minimumDate = self.vm.fromDate {
            maxDate = calendar.date(byAdding: .day, value: +7, to: calendar.startOfDay(for: minimumDate))
        }
        self.openDatePicker(minimum: self.vm.fromDate, maximum: maxDate, sender: sender as! UIView) { selectedDate in
            self.vm.toDate = selectedDate
            if let date = selectedDate {
                self.btnTo.setTitle(date.string(), for: .normal)
            }
        }
    }
    
    @IBAction func tappedOnSubmit(_ sender: Any) {
        if self.vm.validateTheRange() {
            self.vm.getAstroids {
                self.tblData.reloadData()
                self.chart.reloadData()
            }
        } else {
            self.showAlert(with: "", message: "Please choose from date and to date")
        }
    }
    

}
extension ViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.differentAstroids?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatCell") as! StatCell
        cell.obj = self.vm.differentAstroids![indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
}
extension ViewController:AWLineChartDataSource {
    func numberOfBottomLabels(in lineChart: AWLineChart) -> Int {
        return self.vm.sortedAstroids!.count
    }
    
    func numberOfSideLabels(in lineChart: AWLineChart) -> Int {
        return self.vm.sortedAstroids!.count
    }
    
    func numberOfVerticalLines(in lineChart: AWLineChart) -> Int {
        return self.vm.sortedAstroids!.count
    }
    
    func numberOfHorizontalLines(in lineChart: AWLineChart) -> Int {
        return self.vm.sortedAstroids!.count
    }
    
    func lineChart(_ lineChart: AWLineChart, yValueAt index: Int) -> CGFloat {
        return CGFloat(self.vm.sortedAstroids![index].astroids!.count)
    }
    
    func lineChart(_ lineChart: AWLineChart, verticalDashPatternAt index: Int) -> [NSNumber] {
        []
    }
    
    func lineChart(_ lineChart: AWLineChart, horizontalDashPatternAt index: Int) -> [NSNumber] {
        []
    }
    
    func numberOfItems(in lineChart: AWLineChart) -> Int {
        return self.vm.sortedAstroids!.count
    }
       
       func lineChart(_ lineChart: AWLineChart, xValueAt index: Int) -> String {
           return self.vm.sortedAstroids![index].date!.shortFormat()
       }
}
