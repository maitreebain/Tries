import UIKit

//implement a Trie node

/*
 EXAMPLE:
 class TrieNode {
   var char: Character // the character of the node
   var isCompleteWord: Bool // bool to indicate if the path is a complete word
   var children: [Character: TrieNode] // the children of the parent node
   var parent: TrieNode? // parent useful in thhe case of deleting nodes
   
   init(_ char: Character, parent: TrieNode? = nil) {
     self.char = char
     self.parent = parent
     self.isCompleteWord = false
     self.children = [:]
   }
   
   // add a new child to the node's children
   public func add(_ child: Character) {
     // check to see if the node already exist
     guard children[child] == nil else { return }
     
     // if not, create a new child
     children[child] = TrieNode(child, parent: self)
   }
 }
 */

class TrieNode {
    //struct cannot point to itself
    //properties: char, parent, children, delimeter signifying if path is a word
    var char: Character
    var parent: TrieNode?
    var children: [Character: TrieNode]
    var isWordComplete: Bool
    //initializer
    init(char: Character, parent: TrieNode? = nil) {
        self.char = char
        self.parent = parent
        self.children = [:]
        self.isWordComplete = false
    }
    
    //method called add() to child nodes
    
    func add(child: Character) {
        //check if child does not exist insert a new key,value pair
        guard children[child] == nil else { return }
        //insert new value(TrieNode) in dictionary
        children[child] = TrieNode(char: child, parent: self)
        
    }
}

class Trie {
    //will have a rootnode property
    private var root: TrieNode
    
    init() {
        self.root = TrieNode(char: "*")
        
    }
    
    //insert
    func insert(_ word: String) {
        //start at root node - "swift"
        var currentNode = root
        
        for char in word {
            //check if child node exists for currentNode
            if let childNode = currentNode.children[char] {
                //keep traversing the trie
                currentNode = childNode
            } else {
                currentNode.add(child: char)
                currentNode = currentNode.children[char]!
            }
        }
        guard !currentNode.isWordComplete else { return }
        
        currentNode.isWordComplete = true
    }
    
    //getNode -> TrieNode?
    func getNode(_ word: String) -> TrieNode? {
        var currentNode = root
        
        for char in word {
            guard let childNode = currentNode.children[char] else { return nil }
            //if we find a child node keep traversing
            currentNode = childNode
        }
        
        return currentNode
    }
    
    //search
    func search(_ word: String) -> Bool {
        guard let node = getNode(word) else { return false }
        
        return node.isWordComplete
    }
    
    
    //prefix
    //search for a prefix of a word
    func startWith(_ prefix: String) -> Bool {
        guard let _ = getNode(prefix) else { return false}
        return true //doesn't care weather full word or not
    }
}

//test our Trie

let trie = Trie()
//insert words into trie
//case sensitive
trie.insert("swift")
trie.insert("sweet")
trie.insert("sweater")
trie.insert("sat")

trie.search("alex")
trie.search("sat")
trie.startWith("sw")

trie.search("sweat")
trie.startWith("sweat")

//redo from scratch
