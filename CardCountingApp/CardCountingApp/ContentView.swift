//
//  ContentView.swift
//  CardCountingApp
//
//  Created by Darren Wu on 3/22/22.
//

import SwiftUI
private var numToSuit = ["1":"clubs",
                         "2":"hearts",
                         "3":"diamonds",
                         "4":"spades"]



struct ContentView: View {
    @State private var index = 0
    @State var myDeck = createDeck()
    @State var nextCardButton = "Next Card"
    @State var checkCardButton = "Check Count"
    @State var displayCount = ""
    @State var currentCount = 0
     
    
    
   
    
    var body: some View {
       
        ZStack{
            Image("Background").resizable().edgesIgnoringSafeArea(.all)
        VStack{Text("Card Counter").font(.system(.largeTitle, design: .rounded))
            Spacer()
            HStack{
                Image(stringToCard(str: self.myDeck[index] as! String))
                    .resizable()
                    .frame(width: 300.0, height: 450.0)
            }
    
            HStack{
                Text("Cards Left")
                Text(String(myDeck.count - index - 1)+"/" + String(myDeck.count))
            }
        
            Spacer()
            HStack{
                Spacer()
                VStack{
                    Button(action: {
                        if(checkCardButton == "Check Count"){
                            if(self.index == 0){
                                self.currentCount = (returnCount(card: self.myDeck[index] as! String))
                            }
                            displayCount = String(currentCount)
                            checkCardButton = "Hide Count"
                        }
                        else{
                            checkCardButton = "Check Count"
                            displayCount = ""
                        }
                        
                    }, label: {
                        Text(checkCardButton)
                    })
                    .padding()
                    .background(Color(red: 1, green: 1, blue: 1))
                    .clipShape(Capsule())
                    Text(displayCount)
                }
                Spacer()
                VStack{
                    Button(action: {
                        if(myDeck.count - index - 1 != 0){
                            self.index = self.index + 1
                            self.currentCount = self.currentCount + (returnCount(card: self.myDeck[index] as! String))
                            if(checkCardButton == "Hide Count"){
                                self.displayCount = String(self.currentCount)
                            }
                            if(myDeck.count - index - 1 == 0){
                                self.nextCardButton = "Empty Deck"
                            }
                        }
                        else{
                            nextCardButton = "Empty Deck"
                        }
                    
                    }, label: {
                        Text(nextCardButton)
                    })
                    .padding()
                    .background(Color(red: 1, green: 1, blue: 1))
                    .clipShape(Capsule())
                    Text("")
                }
                Spacer()
            }
            
            HStack(){
                Button(action: {
                    self.myDeck = createDeck()
                    self.index = 0
                    self.nextCardButton = "Next Card"
                    self.currentCount = (returnCount(card: self.myDeck[index] as! String))
                    if(self.checkCardButton != "Check Count"){
                        self.displayCount = String(self.currentCount)
                    }
                }, label: {
                    Text("Reset Deck")
                })
                .padding()
                .background(Color(red: 1, green: 1, blue: 1))
                .clipShape(Capsule())
                
            }
            
        }
        }
        
    }
}


func returnCount(card: String)-> Int{
    var cardNum = ""
    
    if(card.count == 3){
        cardNum = String(card.suffix(2))
    }
    else{
        cardNum = String(card.suffix(1))
    }
    
    let intCard = Int(cardNum)
    
    if(intCard ?? 0 >= 2 && intCard ?? 0 < 7){
        return 1
    }
    else{
        if(intCard ?? 0 == 1 || intCard ?? 0 >= 10){
            return -1
        }
        else{
            return 0
        }
    }
}
func createDeck()->Array<Any>{
    var deck: [String] = []
    for i in 1...4{
        for j in 1...13{
            let card = String(i) + String(j)
            deck.append(card)
        }
    }
    deck.shuffle()
    return deck
}

func stringToCard(str: String)->String{
    let suitNum = String(str[str.startIndex])
    
    let suit = numToSuit[suitNum] ?? "clubs"
    var res = ""
    var cardNum = ""
    if(str.count == 3){
        cardNum = String(str.suffix(2))
    }
    else{
        cardNum = String(str.suffix(1))
    }
  
    
    res += "card-" + suit + "-" + cardNum
    
    return res
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}

