import UIKit
import AVFoundation

final class QRCodeScannerViewController: UIViewController {

    private var captureSession: AVCaptureSession?

    var previewLayer: AVCaptureVideoPreviewLayer?

    let feedback = UINotificationFeedbackGenerator()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "QR"

        start()

        feedback.prepare()

        if let captureSession = captureSession {
            let preview = AVCaptureVideoPreviewLayer(session: captureSession)
            self.previewLayer = preview
            preview.frame = previewView.layer.bounds
            previewView.layer.addSublayer(preview)
            preview.videoGravity = .resizeAspectFill

            captureSession.startRunning()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if captureSession?.isRunning == false {
            captureSession?.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if captureSession?.isRunning == true {
            captureSession?.stopRunning()
        }
    }

    // MARK: -

    func start() {
        setup()
    }

    // MARK: - Setup

    private func setup() {
        captureSession = AVCaptureSession()

        setupDeviceInput()
        setupMetadataOutput()
    }

    // Add camera device
    private func setupDeviceInput() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }

        if let deviceInput = try? AVCaptureDeviceInput(device: captureDevice) {
            if let session = captureSession {
                if session.canAddInput(deviceInput) {
                    session.addInput(deviceInput)
                }
            }
        }
    }

    // Set QR code output
    private func setupMetadataOutput() {
        if let session = captureSession {
            let metadataOutput = AVCaptureMetadataOutput()

            if session.canAddOutput(metadataOutput) {
                session.addOutput(metadataOutput)

                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.qr]
            }
        }
    }

    // MARK: - Views

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet weak var previewView: UIView!

}

extension QRCodeScannerViewController: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        // Stop session
        captureSession?.stopRunning()

        // Haptic feedback - works??
        feedback.notificationOccurred(.success)

        //
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }

            print("Found: \(stringValue)")
            dismiss(animated: true)
        }
    }

}
