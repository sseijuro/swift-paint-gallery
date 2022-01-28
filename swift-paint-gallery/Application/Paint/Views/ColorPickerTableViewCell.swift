import UIKit

final class ColorPickerTableViewCell: UITableViewCell {
    static let identifier = String(describing: ColorPickerTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    func setBackgroundColor(_ color: UIColor) {
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
