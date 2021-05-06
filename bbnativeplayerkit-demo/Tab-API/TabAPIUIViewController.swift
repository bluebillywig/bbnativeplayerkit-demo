import UIKit
import BBNativePlayerKit
import AVFoundation
import AVKit
import bbnativeshared

class TabAPIUIViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var APIActionUIPickerView: UIPickerView!
    
    private var bbPlayerView: BBNativePlayerView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data to UIPickerView:
        APIActionUIPickerView.dataSource = self
        APIActionUIPickerView.delegate = self

        // create player view using the embed url
        bbPlayerView = BBNativePlayer.createPlayerView(frame: view.frame, jsonUrl: "https://bb.dev.bbvms.com/p/default/c/1092747.json") // verical 1084217  1092747
        
        // use constraints to place and size the player view
        view.addSubview(bbPlayerView!)
        bbPlayerView?.translatesAutoresizingMaskIntoConstraints = false
        bbPlayerView?.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        bbPlayerView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0 ).isActive = true
        bbPlayerView?.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        bbPlayerView?.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width * 9/16).isActive = true
        
        // set class to delegate of player view
        bbPlayerView?.delegate = self
    }
    
    func VideoModal() {
        bbPlayerView = BBNativePlayer.createPlayerView(frame: view.frame, jsonUrl: "https://bb.dev.bbvms.com/p/puc_click_to_play/c/1092747.json")
        bbPlayerView?.presentModal(uiViewContoller: self, animated: true)
    }
    
    //MARK: - API TESTS
    @IBOutlet weak var debugTextLabel: UILabel!
    @IBOutlet weak var debugUIText: UITextField!
    @IBOutlet weak var debugUITextView: UITextView!
    
    
    
    //MARK: - UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return APIActions.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return APIActions[row]
    }
    
    private var APIActions: [String] = ["Select API method", "Play", "Pause", "Load", "GetThumnailUrlString", "getClipData", "getCurrentTime", "getDeeplink", "getDuration", "getMuted", "getPhase", "isPlaying", "getPlayoutData", "getProjectData", "OpenModalPlayer"]
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the APIActionUIPickerView selection.
        // The parameter named row represents what was selected.
        switch APIActions[row] {
        case "Play":
            bbPlayerView?.play()
            break
        case "Pause":
            bbPlayerView?.pause()
            break
        case "Load":
            bbPlayerView?.load(contentId: "1084217", contentIndicator: "c", initiator: nil, autoPlay: true, seekPosition: nil)  // note the autoplay true sot eh video starts playing when it is loaded
            break
        case "GetThumnailUrlString":
            if let thumbnailUrlString = bbPlayerView?.getThumbnailUrlString(clipId: "123456", width: 300, height: 200) {
                showValue(title: "Thumbnail url", message: thumbnailUrlString)
            } else {
                showValue(title: "Thumbnail url", message: "Unable to get thumbnailUrlString")
            }
            break
        case "getClipData":
            if let mediaClip = bbPlayerView?.getClipData() {
                if let clipId = mediaClip.id {
                    showValue(title: "Clip ID", message: clipId)
                }
            } else {
                showValue(title: "Clip Data", message: "Not available atm")
            }
            break
        case "getCurrentTime":
            if let currentTime = bbPlayerView?.getCurrentTime() {
                showValue(title: "Current time", message: String(currentTime))
            } else {
                showValue(title: "Current time", message: "Not available atm")
            }
            break
        case "getDeeplink":
            if let deeplink = bbPlayerView?.getDeeplink() {
                showValue(title: "Deeplink", message: deeplink)
            } else {
                showValue(title: "Deeplink", message: "Not available atm")
            }
            break
        case "getDuration":
            if let duration = bbPlayerView?.getDuration() {
                showValue(title: "Duration", message: String(duration))
            } else {
                showValue(title: "Duration", message: "Not available atm")
            }
            break
        case "getMuted":
            if let muted = bbPlayerView?.getMuted() {
                showValue(title: "Muted?", message: String(muted))
            } else {
                showValue(title: "Muted", message: "Not available atm")
            }
            break
        case "getPhase":
            if let phase = bbPlayerView?.getPhase() {
                showValue(title: "Phase", message: "\(String(describing: phase))")
            } else {
                showValue(title: "Phase", message: "Not available atm")
            }
            break
        case "isPlaying":
            if let playing = bbPlayerView?.isPlaying() {
                showValue(title: "Playing?", message: String(playing))
            } else {
                showValue(title: "Playing", message: "Not available atm")
            }
            break
        case "getPlayoutData":
            if let playout = bbPlayerView?.getPlayoutData() {
                if let name = playout.name {
                    showValue(title: "Playout name", message: name)
                }
            } else {
                showValue(title: "Playout", message: "Not available atm")
            }
            break
        case "getProjectData":
            if let project = bbPlayerView?.getProjectData() {
                if let name = project.name {
                    showValue(title: "Project name", message: name)
                }
            } else {
                showValue(title: "Project", message: "Not available atm")
            }
            break
        case "OpenModalPlayer":
            showValue(title: "Showing video in modal mode name", message: "")
            VideoModal()
            break
        default:
                break
            }
    }
    
    //MARK: - Debug Info in UI
    func showValue(title: String, message: String) {
        debugTextLabel.text = title
        debugUIText.text = message
    }
    
    func addToEventDebug( _ message: String ) {
        debugUITextView.text.append(message + "\n")
        let range = NSMakeRange((debugUITextView.text.count) - 1, 0)
        debugUITextView.scrollRangeToVisible(range)
    }
}




//MARK: - BBNativePlayerViewDelegate in extension

//Implements BBNativePlayerViewDelegate to recieve all API events and logs them in the DebugUITextView
extension TabAPIUIViewController: BBNativePlayerViewDelegate {
    
    func didSetupWithJson(url: String?) {
        addToEventDebug("Player API Delegate: didSetupWithJson")
    }
    
    func didTriggerMediaClipLoaded(data: MediaClip) {
        addToEventDebug("Player API Delegate: didTriggerMediaClipLoaded")
    }

    func didTriggerMediaClipFailed() {
        addToEventDebug("Player API Delegate: didTriggerMediaClipFailed")
    }
    
    func didTriggerViewStarted() {
        addToEventDebug("Player API Delegate: didTriggerViewStarted")
    }
    
    func didTriggerViewFinished() {
        addToEventDebug("Player API Delegate: didTriggerViewFinished")
    }
    
    func didTriggerProjectLoaded(data: Project) {
        addToEventDebug("Player API Delegate: didTriggerProjectLoaded")
    }
    
    func didTriggerCanPlay() {
        addToEventDebug("Player API Delegate: didTriggerCanPlay")
    }
    
    func didTriggerDurationChange(duration: Double) {
        addToEventDebug("Player API Delegate: didTriggerDurationChange : \(duration)")
    }
    
    func didTriggerPlay() {
        addToEventDebug("Player API Delegate: didTriggerPlay")
    }
    
    func didTriggerPause() {
        addToEventDebug("Player API Delegate: didTriggerPause")
    }
    
    func didTriggerPlaying() {
        addToEventDebug("Player API Delegate: didTriggerPlaying")
    }
    
    func didTriggerFinish() {
        addToEventDebug("Player API Delegate: didTriggerFinish")
    }
    
    func didTriggerSeeking() {
        addToEventDebug("Player API Delegate: didTriggerSeeking")
    }
    
    func didTriggerSeeked(seekOffset: Double) {
        addToEventDebug("Player API Delegate: didTriggerSeeked : \(seekOffset)")
    }
    
    func didTriggerStall() {
        addToEventDebug("Player API Delegate: didTriggerStall")
    }
    
    func didTriggerAutoPause() {
        addToEventDebug("Player API Delegate: didTriggerAutoPause")
    }
    
    func didTriggerAutoPausePlay() {
        addToEventDebug("Player API Delegate: didTriggerAutoPausePlay")
    }
    
    func didFailWithError() {
        addToEventDebug("Player API Delegate: didFailWithError")
    }
    
    func didTriggerAdError(error: String?) {
        addToEventDebug("Player API Delegate: didTriggerAdError : \(String(describing: error))")
    }

    func didTriggerResized(dimensions: String?, fullscreen: Bool) {
        addToEventDebug("Player API Delegate: apiDidTriggerResized('\(String(describing: dimensions))', \(fullscreen))")
    }
    
    func didTriggerPhaseChange(phase: Phase?) {
        addToEventDebug("Player API Delegate: didTriggerPhaseChange : \(String(describing: phase))")
    }
    
    func didTriggerStateChange(state: State?) {
        addToEventDebug("Player API Delegate: didTriggerStateChange : \(String(describing: state))")
    }
    
    func didRequestOpenUrl(url: String?) {
        addToEventDebug("Player API Delegate: didRequestOpenUrl : \(String(describing: url))")
    }
}
