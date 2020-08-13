//
//  ViewController.swift
//  垂直的跑马灯
//
//  Created by peterlee on 2020/8/13.
//  Copyright © 2020 peterlee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var marQueeView:WDMarQueeView!
    override func viewDidLoad() {
        super.viewDidLoad()
        marQueeView = WDMarQueeView(frame: CGRect(x: 15, y: 160, width: UIScreen.main.bounds.width - 30, height: 68))
        marQueeView.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        view.addSubview(marQueeView)
        marQueeView.layer.cornerRadius = 10
        marQueeView.start()
        // Do any additional setup after loading the view.
    }

}




///获取随机的获取积分的跑马灯文字
class WDShareRandomManager:NSObject
{
    private override init() {
        super.init()
    }
    
    @objc static let shared: WDShareRandomManager = {
        let ret = WDShareRandomManager()
        return ret
    }()
    
    private var randomData:[NSAttributedString] = [NSAttributedString]()
    
    func getRandomData() -> [NSAttributedString]
    {
        if randomData.count >= 100
        {
            return randomData
        }
        let path = Bundle.main.path(forResource: "random.json", ofType: nil)!
        if let data = NSData(contentsOfFile: path), let jsonArr:[String] = try? JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? [String]
        {
            (0...100).forEach { (_) in
                randomData.append(getRandomAttribute(jsonArr: jsonArr))
            }
            return randomData
        }
        return randomData
    }
    
    private func getRandomAttribute(jsonArr:[String]) -> NSAttributedString
    {
        //处理成为特殊的数据 然后显示
        let str:String = jsonArr.randomElement()?.getSpecialName() ?? "***"
        //M**e invited X friends and earned $XXX
        //从已冻结的女性机器人中，选择 1000 个昵称，赚取的金额随机在 3.9 的 5-100 倍和 3.84 的 10-100 中随机选，生成 100 条轮播假消息。
        let point = Double((5...100).randomElement() ?? 5)*([3.9,3.84].randomElement() ?? 3.84)
        let randomPoint:String = "$" + String(format: "%.2lf", point)
        let friends = (1...10).randomElement() ?? 1
        let content = " invited \(friends) friends and earned \(randomPoint)"
        let attribute = NSMutableAttributedString(string:  str + content ,attributes: [.foregroundColor:UIColor.white as Any,.font:UIFont.systemFont(ofSize: 13) as Any])
        attribute.addAttributes([.foregroundColor:UIColor.brown as Any], range: NSMakeRange(0, str.count))//(hex: 0xFFDB3D)
        attribute.addAttributes([.foregroundColor:UIColor.brown as Any], range: NSMakeRange(attribute.length - randomPoint.count, randomPoint.count))
        return attribute
    }
}

///跑马灯
class WDMarQueeView:UIView,UITableViewDelegate,UITableViewDataSource
{
    private var tableView:UITableView!
    private var datas:[NSAttributedString] = WDShareRandomManager.shared.getRandomData()
    private var timer:Timer?
    private var currentIndex:NSInteger = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = (68)
        tableView.backgroundColor = UIColor.clear//(hex: 0xFFAD00)
        addSubview(tableView)
        tableView.isUserInteractionEnabled = false
        tableView.register(WDSingleLabelCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(WDSingleLabelCell.self))
        tableView.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:WDSingleLabelCell? = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(WDSingleLabelCell.self)) as? WDSingleLabelCell
        if (cell != nil)  {
            cell = WDSingleLabelCell()
        }
        cell?.titleLabel?.attributedText = datas[indexPath.row]
        return cell!
    }
    
    ///开启动画
    func start() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { [weak self](t) in
                if let temp = self
                {
                    temp.currentIndex = temp.currentIndex >= temp.datas.count - 1 ? 0:temp.currentIndex + 1
                    temp.tableView.scrollToRow(at: IndexPath(row: temp.currentIndex, section: 0), at: .none, animated: true)
                }
            })
            RunLoop.current.add(timer!, forMode: .common)
        }
    }
    
    ///暂停动画
    func pause() {
        if timer != nil
        {
            timer?.invalidate()
            timer = nil
        }
    }
    
    deinit {
        if timer != nil
        {
            timer?.invalidate()
            timer = nil
        }
    }
    
}

class WDSingleLabelCell:UITableViewCell{
     var titleLabel:UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byTruncatingMiddle
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = self.bounds
    }
}


extension String{
    //获取特殊要去的名字
    func getSpecialName() -> String
    {
        if self.count > 0
        {
            let first = (self as NSString).substring(to: 1)
            if self.count  >= 3
            {
                let last = (self as NSString).substring(from: self.count - 1)
                return "\(first)**\(last)"
            }
            return "\(first)**"
        }
        else
        {
            return "***"
        }
    }
}
