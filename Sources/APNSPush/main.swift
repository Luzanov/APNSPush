import Dispatch
import Foundation
import CryptorECC

#if os(Linux)
import FoundationNetworking
#endif

let production = false
let topic = "<YOUR APP'S BUNDLE ID>"
let deviceToken = "<YOUR DEVICE TOKEN>"
let aps = ["aps": ["sound": "default", "alert": ["title": "Title", "body": "Message"]]]
let keyId = "<YOUR PRIVATE KEY ID>"
let teamId = "<YOUR TEAM ID>"
let privateKey = """
<YOUR PRIVATE KEY>
"""


let iat = UInt64(Date().timeIntervalSince1970)
let header: [String: Any] = ["alg": "ES256", "typ": "JWT", "kid": keyId]
let claims: [String: Any] = ["iat": iat, "iss": teamId]
let token: String

do {
    let JWTHeader = try JSONSerialization.data(withJSONObject: header).base64EncodedString()
    let JWTClaims = try JSONSerialization.data(withJSONObject: claims).base64EncodedString()
    let unsignedJWT = "\(JWTHeader).\(JWTClaims)"
    let ecPrivateKey = try ECPrivateKey(key: privateKey)
    let signature = try unsignedJWT.sign(with: ecPrivateKey)
    token = "\(unsignedJWT).\(signature.asn1.base64EncodedString())"
} catch {
    print(error.localizedDescription)
    exit(0)
}


let url: URL

if production {
    url = URL(string: "https://api.push.apple.com/3/device/\(deviceToken)")!
} else {
    url = URL(string: "https://api.development.push.apple.com/3/device/\(deviceToken)")!
}

var request = URLRequest(url: url)
request.httpMethod = "POST"
request.addValue("bearer \(token)", forHTTPHeaderField: "authorization")
request.addValue(topic, forHTTPHeaderField: "apns-topic")
request.httpBody = try! JSONSerialization.data(withJSONObject: aps)

URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
    if let response = response as? HTTPURLResponse {
        print(response.statusCode == 200 ? "success" : "error")
    } else {
        print(error?.localizedDescription ?? "Unknown error")
    }
    exit(0)
}).resume()

dispatchMain()
