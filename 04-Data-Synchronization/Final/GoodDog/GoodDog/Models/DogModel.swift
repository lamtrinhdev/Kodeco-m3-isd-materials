/// Copyright (c) 2024 Kodeco Inc.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import SwiftData
#if !os(macOS)
import UIKit
#endif

@Model
class DogModel {
  var name: String = ""
  var age: Int?
  var weight: Int?
  var color: String?
  //@Relationship(inverse: \BreedModel.name) // this is inferred
  var breed: BreedModel?
  @Attribute(.externalStorage) var image: Data?
  var parks: [ParkModel]?
  
  init(
    name: String,
    age: Int = 0,
    weight: Int = 0,
    color: String? = nil,
    breed: BreedModel? = nil,
    image: Data? = nil,
    parks: [ParkModel]? = nil
  ) {
    self.name = name
    self.age = age
    self.weight = weight
    self.color = color
    self.breed = breed
    self.image = image
    self.parks = parks
  }
}

extension DogModel {
  @MainActor
  static var preview: ModelContainer {
    do {
      let container = try ModelContainer(for: DogModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
      
      // breeds
      let labrador = BreedModel(name: "Labrador Retriever")
      let golden = BreedModel(name: "Golden Retriever")
      let bouvier = BreedModel(name: "Bouvier")
      let mixed = BreedModel(name: "Mixed")
      
      let riverdale = ParkModel(name: "Riverdale Park")
      let withrow = ParkModel(name: "Withrow Park")
      let greenwood = ParkModel(name: "Greewood Park")
      let hideaway = ParkModel(name: "Hideaway Park")
      let kewBeach = ParkModel(name: "Kew Beach Off Leash Dog Park")
      let allan = ParkModel(name: "Allan Gardens")
      
      #if !os(macOS)
      let macDog = DogModel(
        name: "Mac",
        age: 11,
        weight: 90,
        color: "Yellow",
        breed: labrador,
        image: UIImage(resource: .macintosh).pngData()!,
        parks: [
          riverdale,
          withrow,
          kewBeach
        ]
      )
      let sorcha = DogModel(
        name: "Sorcha",
        age: 1,
        weight: 40,
        color: "Yellow",
        breed: golden,
        image: UIImage(resource: .sorcha).pngData()!,
        parks: [
          greenwood,
          withrow
        ]
      )
      let violet = DogModel(
        name: "Violet",
        age: 4,
        weight: 85,
        color: "Gray",
        breed: bouvier,
        image: UIImage(resource: .violet).pngData()!,
        parks: [
          riverdale,
          withrow,
          hideaway
        ]
      )
      let kirby = DogModel(
        name: "Kirby",
        age: 11,
        weight: 95,
        color: "Fox Red",
        breed: labrador,
        image: UIImage(resource: .kirby).pngData()!,
        parks: [
          allan,
          greenwood,
          kewBeach
        ]
      )
      let priscilla = DogModel(
        name: "Priscilla",
        age: 17,
        weight: 65,
        color: "White",
        breed: mixed,
        image: nil,
        parks: []
      )
      #else
      let macDog = DogModel(
        name: "Mac",
        age: 11,
        weight: 90,
        color: "Yellow",
        breed: labrador,
        image: nil,
        parks: [
          riverdale,
          withrow,
          kewBeach
        ]
      )
      let sorcha = DogModel(
        name: "Sorcha",
        age: 1,
        weight: 40,
        color: "Yellow",
        breed: golden,
        image: nil,
        parks: [
          greenwood,
          withrow
        ]
      )
      let violet = DogModel(
        name: "Violet",
        age: 4,
        weight: 85,
        color: "Gray",
        breed: bouvier,
        image: nil,
        parks: [
          riverdale,
          withrow,
          hideaway
        ]
      )
      let kirby = DogModel(
        name: "Kirby",
        age: 11,
        weight: 95,
        color: "Fox Red",
        breed: labrador,
        image: nil,
        parks: [
          allan,
          greenwood,
          kewBeach
        ]
      )
      let priscilla = DogModel(
        name: "Priscilla",
        age: 17,
        weight: 65,
        color: "White",
        breed: mixed,
        image: nil,
        parks: []
      )
      #endif
      
      
      container.mainContext.insert(macDog)
      container.mainContext.insert(sorcha)
      container.mainContext.insert(violet)
      container.mainContext.insert(kirby)
      container.mainContext.insert(priscilla)
      
      return container
    } catch {
      print("Fatal Error: Could not create preview modelContainer.")
      // Return an empty or default ModelContainer
      do {
        return try ModelContainer(for: DogModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
      } catch {
        fatalError("Failed to create fallback ModelContainer.")
      }
    }
  }
}
