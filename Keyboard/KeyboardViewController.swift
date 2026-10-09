import SwiftUI
import UIKit

private enum KeyboardEmoticonLibrary {
    static let all = [
        "¯\\_(ツ)_/¯",
        "(งಠ_ಠ)ง",
        "(╯°益°)╯彡┻━┻",
        "(ヘ＿　＿)ヘ",
        "[ ± _ ± ]",
        "( ͡° ͜ʖ ͡°)",
        "(͡° ͜ʖ ͡°)",
        "ಠ_ಠ",
        "٩(͡๏̯͡๏)۶",
        "(⊙_☉)",
        "(っ- ‸ – ς)",
        "(∪｡∪)｡｡｡zzz",
        "＼(◎o◎)／",
        "┗(°0°)┛",
        "(-_ゞ",
        "(◑́_◑᷅ )",
        "u_u",
        "(◕‿◕)",
        "＼(＾▽＾)／",
        "(ノ*ﾟ▽ﾟ*)",
        "(￢_￢)",
        "(¬‿¬ )",
        "(⊙_⊙)",
        "(・▽・)/♫•*¨*•.¸¸♪",
        "(￣^￣)ゞ",
        "(　･ω･)☞",
        "╭∩╮(Ο_Ο)╭∩╮",
        "🖕",
        "▄︻̷̿┻̿═━一",
        "༼ つ ◕_◕ ༽つ",
        "(づ￣ ³￣)づ",
        "[̲̅$̲̅(̲̅5̲̅)̲̅$̲̅]",
        "ʕ•ᴥ•ʔ",
        "(▀̿Ĺ̯▀̿ ̿)",
        "(ಥ﹏ಥ)",
        "(☞ﾟヮﾟ)☞ ☜(ﾟヮﾟ☜)",
        "┬┴┬┴┤(･_├┬┴┬┴",
        "ᕙ( ︡'︡益'︠)ง",
        "ᕙ(⇀‸↼‶)ᕗ",
        "ヽ(⌐▀̿_▀̿)ノ♪♬"
    ]
}

final class KeyboardControllerReference {
    weak var controller: KeyboardViewController?
}

final class KeyboardActions {
    private let insertText: (String) -> Void
    private let deleteBackward: () -> Void
    private var deletionTimer: Timer?

    init(insertText: @escaping (String) -> Void, deleteBackward: @escaping () -> Void) {
        self.insertText = insertText
        self.deleteBackward = deleteBackward
    }

    func insert(_ text: String) {
        insertText(text)
    }

    func delete() {
        deleteBackward()
    }

    func beginDeleting() {
        delete()
        deletionTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] _ in
            self?.delete()
        }
    }

    func endDeleting() {
        deletionTimer?.invalidate()
        deletionTimer = nil
    }
}

final class KeyboardViewController: UIInputViewController {
    private let controllerReference = KeyboardControllerReference()
    private lazy var actions = KeyboardActions(
        insertText: { [weak self] text in self?.textDocumentProxy.insertText(text) },
        deleteBackward: { [weak self] in self?.textDocumentProxy.deleteBackward() }
    )

    private var hostingController: UIHostingController<KeyboardRootView>?
    private var keyboardHeightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        controllerReference.controller = self
        view.backgroundColor = .clear
        view.isOpaque = false
        keyboardHeightConstraint = view.heightAnchor.constraint(equalToConstant: preferredKeyboardHeight)
        keyboardHeightConstraint?.priority = .required
        keyboardHeightConstraint?.isActive = true

        let hostingController = UIHostingController(rootView: makeRootView())
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        hostingController.view.isOpaque = false
        view.addSubview(hostingController.view)
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
        self.hostingController = hostingController
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateKeyboardHeight()
        updateRootView()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            self?.updateKeyboardHeight()
        }
    }

    override func textDidChange(_ textInput: UITextInput?) {
        super.textDidChange(textInput)
        updateRootView()
    }

    private var preferredKeyboardHeight: CGFloat {
        traitCollection.verticalSizeClass == .compact ? 216 : 291
    }

    private func updateKeyboardHeight() {
        keyboardHeightConstraint?.constant = preferredKeyboardHeight
    }

    private func updateRootView() {
        hostingController?.rootView = makeRootView()
    }

    private func makeRootView() -> KeyboardRootView {
        KeyboardRootView(
            actions: actions,
            controllerReference: controllerReference,
            usesDarkAppearance: textDocumentProxy.keyboardAppearance == .dark,
            showsInputModeButton: needsInputModeSwitchKey
        )
    }
}

private struct KeyboardRootView: View {
    let actions: KeyboardActions
    let controllerReference: KeyboardControllerReference
    let usesDarkAppearance: Bool
    let showsInputModeButton: Bool

    private var foregroundColor: Color {
        usesDarkAppearance ? .white : .black
    }

    var body: some View {
        VStack(spacing: 0) {
            List {
                Section {
                    ForEach(KeyboardEmoticonLibrary.all, id: \.self) { emoticon in
                        Button {
                            actions.insert(emoticon)
                        } label: {
                            HStack {
                                Text(emoticon)
                                    .font(.body)
                                    .foregroundStyle(foregroundColor)

                                Spacer(minLength: 0)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .listRowBackground(Color.clear)
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.black.opacity(0.001))
//            .contentShape(Rectangle())

            HStack(spacing: 10) {
                if showsInputModeButton {
                    InputModeSwitchButton(controllerReference: controllerReference)
                        .frame(width: 48, height: 44)
                }

                Button {
                    actions.insert(" ")
                } label: {
                    Image(systemName: "space")
                        .frame(maxWidth: .infinity)
                }
                .keyboardKeyStyle(usesDarkAppearance: usesDarkAppearance)

                Button {
                    actions.delete()
                } label: {
                    Image(systemName: "delete.left")
                        .frame(width: 48)
                }
                .keyboardKeyStyle(usesDarkAppearance: usesDarkAppearance)
                .onLongPressGesture(
                    minimumDuration: 0.35,
                    pressing: { isPressing in
                        if isPressing {
                            actions.beginDeleting()
                        } else {
                            actions.endDeleting()
                        }
                    },
                    perform: {}
                )
            }
            .padding(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
    }
}

private extension View {
    func keyboardKeyStyle(usesDarkAppearance: Bool) -> some View {
        buttonStyle(SystemKeyboardControlStyle(usesDarkAppearance: usesDarkAppearance))
    }
}

private struct SystemKeyboardControlStyle: ButtonStyle {
    let usesDarkAppearance: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(usesDarkAppearance ? Color.white : Color.black)
            .frame(minHeight: 44)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(keyColor)
                    .shadow(
                        color: Color.black.opacity(usesDarkAppearance ? 0.35 : 0.2),
                        radius: 0,
                        x: 0,
                        y: 1
                    )
            }
            .opacity(configuration.isPressed ? 0.7 : 1)
    }

    private var keyColor: Color {
        usesDarkAppearance
            ? Color(red: 0.34, green: 0.35, blue: 0.37)
            : .white
    }
}

private struct InputModeSwitchButton: UIViewRepresentable {
    let controllerReference: KeyboardControllerReference

    func makeCoordinator() -> Coordinator {
        Coordinator(controllerReference: controllerReference)
    }

    func makeUIView(context: Context) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "globe"), for: .normal)
        button.addTarget(
            context.coordinator,
            action: #selector(Coordinator.handleInputModeList(_:for:)),
            for: .allTouchEvents
        )
        return button
    }

    func updateUIView(_ button: UIButton, context: Context) {}

    final class Coordinator: NSObject {
        private let controllerReference: KeyboardControllerReference

        init(controllerReference: KeyboardControllerReference) {
            self.controllerReference = controllerReference
        }

        @objc func handleInputModeList(_ sender: UIButton, for event: UIEvent) {
            controllerReference.controller?.handleInputModeList(from: sender, with: event)
        }
    }
}
