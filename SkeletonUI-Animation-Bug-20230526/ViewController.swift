import SwiftUI
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let presentButton: UIButton = {
            let button = UIButton()
            button.setTitle("Present List", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 20)
            button.addTarget(self, action: #selector(presentList), for: .touchUpInside)
            button.setTitleColor(.black, for: .normal)
            return button
        }()
        presentButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(presentButton)

        NSLayoutConstraint.activate([
            presentButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            presentButton.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }

    @objc func presentList() {
        let rootView = AlbumList()
        let hostingController = UIHostingController(rootView: rootView)
        hostingController.modalPresentationStyle = .overFullScreen
        self.present(hostingController, animated: true)
    }

}

