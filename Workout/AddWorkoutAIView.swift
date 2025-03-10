import SwiftUI
import OpenAISwift

final class ChatBot: ObservableObject {
    
    init(){
        
    }
    
    private var client: OpenAISwift?
    
    func setup()  {
        let apiConfig = OpenAISwift.Config.makeDefaultOpenAI(apiKey: "")
        client = OpenAISwift(config: apiConfig)
    }
    func send(text: String, completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let success):
            let output = success.choices?.first?.text ?? ""
                completion(output)
            case .failure(let failure):
                print(failure.localizedDescription)
                
            }
            
        })
    }
}


struct AddWorkoutAIView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AddWorkoutAIView()
}
