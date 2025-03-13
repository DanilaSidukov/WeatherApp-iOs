import Foundation
import SwiftUI

final class ButtonAdd: UIButton {
    
    var onClick: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = bounds.height / 2
        self.setTitle(stringRes("add"),for: .normal)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.setTitleColor(.black,for: .normal)
        self.setImage(UIImage(named: "ic_add"),for: .normal)
        self.backgroundColor = UIColor.white
        self.contentEdgeInsets = UIEdgeInsets(
            top: 7, left: 16, bottom: 7, right: 16
        )
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        self.addTarget(self, action: #selector(onClickButton), for: .touchUpInside)
    }
    
    @objc private func onClickButton() {
        onClick?()
    }
}

// Обёртка для UIView для использования в SwiftUI
struct ButtonAddPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> ButtonAdd {
        let sampleItem = ButtonAdd()
        return sampleItem
    }
    
    func updateUIView(_ uiView: ButtonAdd, context: Context) {
        // Обновления для UIView, если нужно
    }
}

#Preview {
    return ZStack {
        Color.baseBackground // Фон экрана
        ButtonAddPreview()
    }
    .fixedSize()
}
