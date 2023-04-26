import Foundation

struct Service {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func fetchList(of user: String, completion: @escaping ([Repository]?) -> Void) {
        
        // TODO
        let stringURL = URL(string: "https://api.github.com/users/\(user)/repos")
        
        guard let url = stringURL else {
            completion(nil)
            return
        }
        
        network.performGet(url: url) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let repositories = try JSONDecoder().decode([Repository].self, from: data)
                completion(repositories)
            } catch {
                print("Erro ao decodificar")
                completion(nil)
            }
        }
    }
}
