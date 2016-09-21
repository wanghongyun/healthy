//
//  ChartController.swift
//  healthy
//
//  Created by BanDouMacmini-1 on 16/9/20.
//  Copyright © 2016年 WHY. All rights reserved.
//

import UIKit

class ChartController: BaseController {
    
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var filterContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.filterContainer.layer.borderWidth = 1.0
        self.filterContainer.layer.borderColor = UIColor(white: 0.9, alpha: 1.0).cgColor
        
        self.heartRate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: action
    @IBAction func heartRateClick(_ sender: UIButton) {
        self.heartRate()
    }
    
    @IBAction func diastolicClick(_ sender: UIButton) {
        self.diastolic()
    }
    
    @IBAction func systolicClick(_ sender: UIButton) {
        self.systolic()
    }
    
    // MARK: data
    func heartRate() {
        let listData = self.demoData(range: 65, offset: 50)
        let lineData = self.createLineData(listData: listData, chartName: "心率")
        self.setupLineChart(lineData: lineData, limitLine: 110.0, maxValue: 150.0, minValue: 40.0)
        
        let pieData = self.createPieData(listData: listData, range: [60,85,110], label: "心率")
        self.setupPieChart(pieData: pieData, label: "心率")
    }
    
    func diastolic() {
        let listData = self.demoData(range: 50, offset: 55)
        let lineData = self.createLineData(listData: listData, chartName: "舒张压")
        self.setupLineChart(lineData: lineData, limitLine: 90.0, maxValue: 110.0, minValue: 50.0)
        
        let pieData = self.createPieData(listData: listData, range:  [60,85,100], label: "舒张压")
        self.setupPieChart(pieData: pieData, label: "舒张压")
    }
    
    func systolic() {
        let listData = self.demoData(range: 70, offset: 80)
        let lineData = self.createLineData(listData: listData, chartName: "收缩压")
        self.setupLineChart(lineData: lineData, limitLine: 140.0, maxValue: 190.0, minValue: 90.0)

        let pieData = self.createPieData(listData: listData, range: [90,110,140], label: "收缩压")
        self.setupPieChart(pieData: pieData, label: "收缩压")
    }
    
    // MARK: line chart
    func setupLineChart(lineData: LineChartData, limitLine: Double, maxValue: Double, minValue: Double) {
         self.lineChart.clear()
        
        let color = UIColor(red: 38.0/255.0, green: 168.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        
        let yAxis = self.lineChart.getAxis(.left)
        let yAxisR = self.lineChart.getAxis(.right)
        yAxisR.enabled = false
        yAxis.removeAllLimitLines()
        yAxis.axisLineWidth = 1.0
//        yAxis.axisLineColor = UIColor(red: 0.0, green: 153.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        yAxis.axisLineColor = color
        yAxis.axisMaximum = maxValue
        yAxis.axisMinimum = minValue
        
        let ll = ChartLimitLine(limit: limitLine, label: "警戒线")
        let alarmColor = UIColor(red: 30.0/255.0, green: 130.0/255.0, blue: 76.0/255.0, alpha: 1.0) //rgba(30, 130, 76, 1.0)
        ll.lineWidth = 1.0
        ll.valueFont = UIFont.boldSystemFont(ofSize: 11)
        ll.valueTextColor = alarmColor
        ll.lineColor = alarmColor
        yAxis.addLimitLine(ll)
        
        let xAxis = self.lineChart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.axisLineWidth = 1.0
//        xAxis.axisLineColor = UIColor(red: 0.0, green: 153.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        xAxis.axisLineColor = color
        
        self.lineChart.drawBordersEnabled = false
        
        self.lineChart.noDataText = "You need to provide data for the chart."
        self.lineChart.chartDescription?.text = "评估报告"
        
        self.lineChart.drawGridBackgroundEnabled = false
        self.lineChart.dragEnabled = true
        self.lineChart.setScaleEnabled(true)
        self.lineChart.data = lineData
        
        let mLegend = self.lineChart.legend
        mLegend.form = .square
        for entity in mLegend.entries {
            entity.formColor = color
        }
        
        self.lineChart.animate(yAxisDuration: 1.5)
    }
    
    func createLineData(listData: [Int], chartName: String) -> LineChartData {
        var coordinate = [ChartDataEntry]()
        
        for i in 0..<listData.count {
            coordinate.append(ChartDataEntry(x: Double(i), y: Double(listData[i])))
        }
        
        let dataSet = LineChartDataSet(values: coordinate, label: chartName)
        dataSet.circleRadius = 4.0
        dataSet.circleHoleRadius = 2.0
        let color = UIColor(red: 38.0/255.0, green: 168.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        dataSet.colors = [color]
        dataSet.circleColors = [color]
        return LineChartData(dataSets: [dataSet])
    }
    
    // MARK: pie chart
    
    func setupPieChart(pieData: PieChartData, label: String) {
        self.pieChart.holeRadiusPercent = 0.4
        self.pieChart.transparentCircleRadiusPercent = 0.5
        self.pieChart.drawCenterTextEnabled = true
        // TODO:
//        self.pieChart.backgroundColor = UIColor(red: 200.0/255.0, green: 247.0/255.0, blue: 97.0/255.0, alpha: 1.0)
        self.pieChart.chartDescription?.text = label + "分布图"
        self.pieChart.drawHoleEnabled = true
        self.pieChart.rotationAngle = 90.0
        self.pieChart.rotationEnabled = true
        self.pieChart.usePercentValuesEnabled = true
        self.pieChart.centerText = label
        
        self.pieChart.data = pieData
        
        let mLegend = pieChart.legend
        mLegend.horizontalAlignment = .left
        mLegend.verticalAlignment = .top
        
        self.pieChart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)
    }
    
    func createPieData(listData: [Int], range: [Int], label: String) -> PieChartData {
        let total = listData.count
        
        var qu1 = 0
        var qu2 = 0
        var qu3 = 0
        var qu4 = 0
        
        for value in listData {
            if value < range[0] {
                qu1 += 1
            } else if value < range[1] {
                qu2 += 1
            } else if value < range[2] {
                qu3 += 1
            } else {
                qu4 += 1
            }
        }
        
        var pieValues = [ChartDataEntry]()
        pieValues.append(PieChartDataEntry(value: Double(qu1)/Double(total), label: "\(range[0])以下"))
        pieValues.append(PieChartDataEntry(value: Double(qu2)/Double(total), label: "\(range[0])~\(range[1])"))
        pieValues.append(PieChartDataEntry(value: Double(qu3)/Double(total), label: "\(range[1])~\(range[2])"))
        pieValues.append(PieChartDataEntry(value: Double(qu4)/Double(total), label: "\(range[2])以上"))
        
        let pieDataSet = PieChartDataSet(values: pieValues, label: label)
        pieDataSet.sliceSpace = 0.0
        
        var colors = [UIColor]()
//        colors.append(UIColor(red: 135.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0))
//        colors.append(UIColor(red: 240.0/255.0, green: 220.0/255.0, blue: 130.0/255.0, alpha: 1.0))
//        colors.append(UIColor(red: 180.0/255.0, green: 240.0/255.0, blue: 60.0/255.0, alpha: 1.0))
//        colors.append(UIColor(red: 255.0/255.0, green: 165.0/255.0, blue: 80.0/255.0, alpha: 1.0))
        
        colors.append(UIColor(red: 0.0/255.0, green: 177.0/255.0, blue: 106.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 38.0/255.0, green: 194.0/255.0, blue: 129.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 46.0/255.0, green: 204.0/255.0, blue: 113.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 1.0/255.0, green: 152.0/255.0, blue: 117.0/255.0, alpha: 1.0))
        
        pieDataSet.colors = colors
        pieDataSet.valueFont = UIFont.systemFont(ofSize: 9.0)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        formatter.percentSymbol = "%"
        let chartData = PieChartData(dataSets: [pieDataSet])
        chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        return chartData
    }
    
    func demoData(range: Int, offset: Int) -> [Int] {
        var list = [Int]()
        for _ in 0..<16 {
            list.append(Int(arc4random_uniform(UInt32(range))) + offset)
        }
        return list
    }
}
