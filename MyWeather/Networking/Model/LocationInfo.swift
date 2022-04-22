import Foundation

// MARK: - LocationElement
struct LocationElement: Codable {
    let name: String?
    let localNames: LocalNames?
    let lat, lon: Double?
    let country, state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

// MARK: - LocalNames
struct LocalNames: Codable {
    let af, ar, ascii, az: String?
    let bg, ca, da, de: String?
    let el, en, eu, fa: String?
    let featureName, fi, fr, gl: String?
    let he, hi, hr, hu: String?
    let id, it, ja, la: String?
    let lt, mk, nl, no: String?
    let pl, pt, ro, ru: String?
    let sk, sl, sr, th: String?
    let tr, vi, zu: String?

    enum CodingKeys: String, CodingKey {
        case af, ar, ascii, az, bg, ca, da, de, el, en, eu, fa
        case featureName = "feature_name"
        case fi, fr, gl, he, hi, hr, hu, id, it, ja, la, lt, mk, nl, no, pl, pt, ro, ru, sk, sl, sr, th, tr, vi, zu
    }
}

typealias Location = [LocationElement]
