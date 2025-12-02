import UIKit

class PlayerOptionsEditorViewController: UIViewController {
    
    weak var delegate: PlayerOptionsEditorDelegate?
    var initialOptions: [String: Any] = [:]
    var jsonUrl: String = ""
    
    // MARK: - UI Elements
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let jsonUrlTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "JSON URL"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // Ad System Section
    private let adsystemBuidTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Bundle ID (adsystem_buid)"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let adsystemRdidTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Device ID (adsystem_rdid)"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let adsystemIdtypeSegment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["idfa", "adid"])
        segment.selectedSegmentIndex = 0
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    private let adsystemIsLatSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    private let adsystemPpidTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Publisher ID (adsystem_ppid)"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // Behavior Section
    private let allowCollapseExpandSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    private let autoPlaySwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    private let commercialsSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    private let noChromeCastSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    private let noStatsSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    private let forceFullscreenLandscapeSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    private let showChromeCastMiniControlsInPlayerSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    // Consent Management Section
    private let waitForCmpSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    private let handleConsentManagementSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    private let tagForUnderAgeOfConsentSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    private let consentStringTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Consent String"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let consentGdprAppliesTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "GDPR Applies (Int)"
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let consentCmpVersionTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "CMP Version"
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // Ad Tag Parameters Section
    private var customOptionParams: [String: String] = [:]
    private let customOptionParamsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let shortsDisplaySegment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Default", "Shelf"])
        segment.selectedSegmentIndex = 0
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        loadInitialValues()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        setupFormSections()
    }
    
    private func setupFormSections() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
        
        // JSON URL Section
        stackView.addArrangedSubview(createSection(title: "Embed URL", views: [jsonUrlTextField]))
        // Custom Parameters Section
        
        let customSection = createSection(title: "Custom Parameters", views: [customOptionParamsStackView])
        let addParameterButton = UIButton(type: .system)
        addParameterButton.setTitle("+ Add Custom Parameter", for: .normal)
        addParameterButton.addTarget(self, action: #selector(addCustomParameter), for: .touchUpInside)
        customSection.addArrangedSubview(addParameterButton)
        stackView.addArrangedSubview(customSection)
        
        // Ad System Section
        stackView.addArrangedSubview(createSection(title: "Ad System", views: [
            adsystemBuidTextField,
            adsystemRdidTextField,
            createLabeledControl("ID Type:", control: adsystemIdtypeSegment),
            createLabeledControl("Limit Ad Tracking:", control: adsystemIsLatSwitch),
            adsystemPpidTextField
        ]))
        
        // Behavior Section
        stackView.addArrangedSubview(createSection(title: "Player Behavior", views: [
            createLabeledControl("Allow Collapse/Expand:", control: allowCollapseExpandSwitch),
            createLabeledControl("Auto Play:", control: autoPlaySwitch),
            createLabeledControl("Allow Commercials:", control: commercialsSwitch),
            createLabeledControl("Disable ChromeCast:", control: noChromeCastSwitch),
            createLabeledControl("Show ChromeCast Mini Controls:", control: showChromeCastMiniControlsInPlayerSwitch),
            createLabeledControl("Disable Stats:", control: noStatsSwitch),
            createLabeledControl("Force Fullscreen Landscape:", control: forceFullscreenLandscapeSwitch),
            createLabeledControl("Shorts Display:", control: shortsDisplaySegment),
        ]))
        
        // Consent Management Section
        stackView.addArrangedSubview(createSection(title: "Consent Management", views: [
            createLabeledControl("Wait for CMP:", control: waitForCmpSwitch),
            createLabeledControl("Handle Consent Management:", control: handleConsentManagementSwitch),
            createLabeledControl("Tag for Under Age:", control: tagForUnderAgeOfConsentSwitch),
            consentStringTextField,
            consentGdprAppliesTextField,
            consentCmpVersionTextField
        ]))
    }
    
    private func createSection(title: String, views: [UIView]) -> UIStackView {
        let sectionStack = UIStackView()
        sectionStack.axis = .vertical
        sectionStack.spacing = 8
        sectionStack.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .label
        sectionStack.addArrangedSubview(titleLabel)
        
        let separator = UIView()
        separator.backgroundColor = .separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        sectionStack.addArrangedSubview(separator)
        
        views.forEach { sectionStack.addArrangedSubview($0) }
        
        return sectionStack
    }
    
    private func createLabeledControl(_ label: String, control: UIView) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let labelView = UILabel()
        labelView.text = label
        labelView.font = .systemFont(ofSize: 14)
        labelView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        stack.addArrangedSubview(labelView)
        stack.addArrangedSubview(control)
        
        return stack
    }
    
    private func setupNavigationBar() {
        title = "Player Options"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveTapped)
        )
    }
    
    private func loadInitialValues() {
        jsonUrlTextField.text = jsonUrl
        
        // Load Ad System values
        adsystemBuidTextField.text = initialOptions["adsystem_buid"] as? String
        adsystemRdidTextField.text = initialOptions["adsystem_rdid"] as? String
        if let idType = initialOptions["adsystem_idtype"] as? String {
            adsystemIdtypeSegment.selectedSegmentIndex = (idType == "adid") ? 1 : 0
        }
        adsystemIsLatSwitch.isOn = initialOptions["adsystem_is_lat"] as? Bool ?? false
        adsystemPpidTextField.text = initialOptions["adsystem_ppid"] as? String
        
        // Load Behavior values
        allowCollapseExpandSwitch.isOn = boolValue(for: "allowCollapseExpand")
        autoPlaySwitch.isOn = boolValue(for: "autoPlay")
        commercialsSwitch.isOn = boolValue(for: "commercials")
        noChromeCastSwitch.isOn = boolValue(for: "noChromeCast")
        showChromeCastMiniControlsInPlayerSwitch.isOn = boolValue(for: "showChromeCastMiniControlsInPlayer")
        noStatsSwitch.isOn = initialOptions["noStats"] as? Bool ?? false
        forceFullscreenLandscapeSwitch.isOn = boolValue(for: "forceFullscreenLandscape")
        if let displayFormat = initialOptions["displayFormat"] as? String {
            shortsDisplaySegment.selectedSegmentIndex = (displayFormat == "list") ? 1 : 0
        }
        
        // Load Consent Management values
        waitForCmpSwitch.isOn = boolValue(for: "waitForCmp")
        handleConsentManagementSwitch.isOn = boolValue(for: "handleConsentManagement")
        tagForUnderAgeOfConsentSwitch.isOn = boolValue(for: "tagForUnderAgeOfConsent")
        consentStringTextField.text = initialOptions["consent_string"] as? String
        if let gdprApplies = initialOptions["consent_gdprApplies"] as? Int {
            consentGdprAppliesTextField.text = String(gdprApplies)
        }
        if let cmpVersion = initialOptions["consent_cmpVersion"] as? Int {
            consentCmpVersionTextField.text = String(cmpVersion)
        }
        
        // Load Custom Parameters
        loadCustomParameters()
    }
    
    private func boolValue(for key: String) -> Bool {
        if let boolValue = initialOptions[key] as? Bool {
            return boolValue
        }
        if let stringValue = initialOptions[key] as? String {
            return stringValue.lowercased() == "true"
        }
        return false
    }
    
    private func loadCustomParameters() {
        let knownOptionKeys: Set<String> = [
            // Ad System options
            "adsystem_buid", "adsystem_rdid", "adsystem_idtype", "adsystem_is_lat", "adsystem_ppid",
            // Behavior options
            "allowCollapseExpand", "autoPlay", "commercials", "noChromeCast", "noStats", "forceFullscreenLandscape", "showChromeCastMiniControlsInPlayer",
            // Consent Management options
            "waitForCmp", "handleConsentManagement", "tagForUnderAgeOfConsent", "consent_string", "consent_gdprApplies", "consent_cmpVersion"
        ]
        
        for (key, value) in initialOptions {
            if key.hasPrefix("adTagUrlParam_") {
                let paramKey = String(key.dropFirst("adTagUrlParam_".count))
                customOptionParams[paramKey] = value as? String
                addCustomParameterRow(key: paramKey, value: value as? String ?? "")
            } else if !knownOptionKeys.contains(key) {
                customOptionParams[key] = value as? String
                addCustomParameterRow(key: key, value: value as? String ?? "")
            }
        }
    }
    
    @objc private func addCustomParameter() {
        let alert = UIAlertController(title: "Add Custom Parameter", message: "", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Parameter Key"
        }
        alert.addTextField { textField in
            textField.placeholder = "Parameter Value"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let key = alert.textFields?[0].text, !key.isEmpty,
                  let value = alert.textFields?[1].text else { return }
            
            self.customOptionParams[key] = value
            self.addCustomParameterRow(key: key, value: value)
        }
        
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func addCustomParameterRow(key: String, value: String) {
        let rowStack = UIStackView()
        rowStack.axis = .horizontal
        rowStack.spacing = 6
        rowStack.translatesAutoresizingMaskIntoConstraints = false
        
        let keyLabel = UILabel()
        keyLabel.text = key
        keyLabel.font = .systemFont(ofSize: 13)
        keyLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let valueField = UITextField()
        valueField.borderStyle = .roundedRect
        valueField.text = value
        valueField.font = .systemFont(ofSize: 13)
        
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("×", for: .normal)
        deleteButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        deleteButton.addTarget(self, action: #selector(deleteCustomParameter(_:)), for: .touchUpInside)
        
        rowStack.addArrangedSubview(keyLabel)
        rowStack.addArrangedSubview(valueField)
        rowStack.addArrangedSubview(deleteButton)
        
        // Store references for deletion
        rowStack.accessibilityIdentifier = key
        
        customOptionParamsStackView.addArrangedSubview(rowStack)
    }
    
    @objc private func deleteCustomParameter(_ sender: UIButton) {
        guard let rowStack = sender.superview as? UIStackView,
              let key = rowStack.accessibilityIdentifier else { return }
        
        customOptionParams.removeValue(forKey: key)
        customOptionParamsStackView.removeArrangedSubview(rowStack)
        rowStack.removeFromSuperview()
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveTapped() {
        var options: [String: Any] = [:]
        
        // Ad System options
        if let buid = adsystemBuidTextField.text, !buid.isEmpty {
            options["adsystem_buid"] = buid
        }
        if let rdid = adsystemRdidTextField.text, !rdid.isEmpty {
            options["adsystem_rdid"] = rdid
        }
        options["adsystem_idtype"] = adsystemIdtypeSegment.selectedSegmentIndex == 0 ? "idfa" : "adid"
        options["adsystem_is_lat"] = adsystemIsLatSwitch.isOn
        if let ppid = adsystemPpidTextField.text, !ppid.isEmpty {
            options["adsystem_ppid"] = ppid
        }
        
        // Behavior options
        options["allowCollapseExpand"] = allowCollapseExpandSwitch.isOn
        options["autoPlay"] = autoPlaySwitch.isOn
        options["commercials"] = commercialsSwitch.isOn
        options["noChromeCast"] = noChromeCastSwitch.isOn
        options["showChromeCastMiniControlsInPlayer"] = showChromeCastMiniControlsInPlayerSwitch.isOn
        options["noStats"] = noStatsSwitch.isOn
        options["forceFullscreenLandscape"] = forceFullscreenLandscapeSwitch.isOn
        options["displayFormat"] = shortsDisplaySegment.selectedSegmentIndex == 0 ? "" : "list"
        
        // Consent Management options
        options["waitForCmp"] = waitForCmpSwitch.isOn
        options["handleConsentManagement"] = handleConsentManagementSwitch.isOn
        options["tagForUnderAgeOfConsent"] = tagForUnderAgeOfConsentSwitch.isOn
        if let consentString = consentStringTextField.text, !consentString.isEmpty {
            options["consent_string"] = consentString
        }
        if let gdprAppliesText = consentGdprAppliesTextField.text, !gdprAppliesText.isEmpty {
            options["consent_gdprApplies"] = Int(gdprAppliesText) ?? 0
        }
        if let cmpVersion = consentCmpVersionTextField.text, !cmpVersion.isEmpty {
            options["consent_cmpVersion"] = Int(cmpVersion) ?? 0
        }
        
        // Custom Parameters - get current values from UI
        for arrangedSubview in customOptionParamsStackView.arrangedSubviews {
            if let rowStack = arrangedSubview as? UIStackView,
               let key = rowStack.accessibilityIdentifier,
               rowStack.arrangedSubviews.count > 1,
               let valueField = rowStack.arrangedSubviews[1] as? UITextField,
               let value = valueField.text, !value.isEmpty {
                options["\(key)"] = value
            }
        }
        
        let finalJsonUrl = jsonUrlTextField.text ?? jsonUrl
        delegate?.didSaveOptions(options, jsonUrl: finalJsonUrl)
        dismiss(animated: true)
    }
}
