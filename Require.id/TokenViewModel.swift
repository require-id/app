//  Require.id 2019

import Foundation

final class TokenViewModel {
    let issuer: String
    let name: String
    let code: String

    init(token: Token) {
        issuer = token.issuer
        name = token.name
        code = token.token
    }
}
