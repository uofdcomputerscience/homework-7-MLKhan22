import Foundation

// For this homework project, we'll be connecting to the "TLDR" server
// to add a few books. The first thing you need to do is create an object
// that we'll upload to the server.

// MARK: - STEP ONE

// Implement a struct that defines a book. A book consists of the following
// items:
// A title, which is a string
// An author, which is a string
// The publication year, as a string (because dates are hard)
// A string for the URL for an image for the book cover
//
// Remember that this structure needs to conform to the `Encodable` protocol.
// Using `Codable` more generally will be useful, as by doing this you'll
// be able to reuse this struct in Project Three.

struct Book : Codable{
    let title: String
    let author: String
    let pubYear: String
    let url: String
}

// MARK: - STEP TWO

// Once you've defined this structure, you'll need to define a couple of
// book objects that you can insert into the database. In order or us to
// have an amusing dataset to work with, each student is requested to
// create five different books for this database.

let book1 = Book(title: "Irish Flooring", author: "Lynn O'Leum", pubYear: "1999", url: "http://www.carpetsandflooring.ie/public/images/gallery/.large.ophelia-73.jpg")
let book2 = Book(title: "Who is Joe?", author: "Joe Mama", pubYear: "2020", url: "https://d1466nnw0ex81e.cloudfront.net/n_iv/600/967553.jpg")
let book3 = Book(title: "Advanced Potion-Making", author: "Libatius Borage", pubYear: "1946", url: "https://cdn.shopify.com/s/files/1/0953/9884/products/Advanced-Potion-Making-Book-cover-Locket-Necklace-keyring-silver-Bronze-tone-B1029.jpg?v=1558452175")
let book4 = Book(title: "For Whom the Bell Tolls", author: "Ernest Hemingway", pubYear: "1976", url: "https://prodimage.images-bn.com/pimages/9781476787770_p0_v2_s550x406.jpg")
let book5 = Book(title: "Cooking Spaghetti", author: "Al Dente", pubYear: "1998", url: "https://prodimage.images-bn.com/pimages/9781476787770_p0_v2_s550x406.jpg")

// MARK: - STEP THREE

// Now we need to publish this data to the server.

// Create a URL to connect to the server. Its address is:
//      https://uofd-tldrserver-develop.vapor.cloud/books

// Create a URL request to publish the information, based upon the URL you
// just created.

// Add the body to the URL request you just created, by using JSONEncoder.

// Add a "Content-Type" : "application/json" header to your request, so that
// the server will properly understand the body of your request.

// Set the method of the request to "POST", because we're providing information
// rather than retrieving it.

// Create a data task for publishing this element, and kick it off with a resume().

let books : [Book]
books = [book1, book2, book3, book4, book5]

func publishData(books: [Book]) {
    for b in books{
        let urlString =  "https://uofd-tldrserver-develop.vapor.cloud/books"
        let server = URL(string: urlString)!
        var request = URLRequest(url: server)
        request.httpBody = try? JSONEncoder().encode(b)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let task = URLSession(configuration: .ephemeral).dataTask(with: request)
        task.resume()
    }
}

publishData(books: books)
// MARK: - HELPFUL HINTS
// You might want to create a method for publishing the data, so that you
// can effectively loop over an array of books.
//
// If you visit the URL for the service in a 'GET' request, it will return a
// list of books to you. We'll be using this list of books for Project Three.
