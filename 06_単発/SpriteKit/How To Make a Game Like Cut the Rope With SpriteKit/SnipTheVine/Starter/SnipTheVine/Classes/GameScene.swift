/// Copyright (c) 2019 Razeware LLC
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
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SpriteKit
import AVFoundation

class GameScene: SKScene {
  private var particles: SKEmitterNode?
  
  override func didMove(to view: SKView) {
    setUpPhysics()
    setUpScenery()
    setUpPrize()
    setUpVines()
    setUpCrocodile()
    setUpAudio()
  }
  
  //MARK: - Level setup
  
  private func setUpPhysics() {
    
  }
  
  private func setUpScenery() {
    let background = SKSpriteNode(imageNamed: ImageName.background)
    background.anchorPoint = CGPoint(x: 0, y: 0)
    background.position = CGPoint(x: 0, y: 0)
    background.zPosition = Layer.background
    background.size = CGSize(width: size.width, height: size.height)
    addChild(background)
    
    let water = SKSpriteNode(imageNamed: ImageName.water)
    water.anchorPoint = CGPoint(x: 0, y: 0)
    water.position = CGPoint(x: 0, y: 0)
    water.zPosition = Layer.foreground
    water.size = CGSize(width: size.width, height: size.height * 0.2139)
    addChild(water)
  }
  
  private func setUpPrize() {
    
  }
  
  //MARK: - Vine methods
  
  private func setUpVines() {
    
  }
  
  //MARK: - Croc methods
  
  private func setUpCrocodile() {
    
  }
  
  private func animateCrocodile() {
    
  }
  
  private func runNomNomAnimation(withDelay delay: TimeInterval) {
    
  }
  
  //MARK: - Touch handling

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    particles?.removeFromParent()
    particles = nil
  }
  
  private func showMoveParticles(touchPosition: CGPoint) {
    if particles == nil {
      particles = SKEmitterNode(fileNamed: Scene.particles)
      particles!.zPosition = 1
      particles!.targetNode = self
      addChild(particles!)
    }
    particles!.position = touchPosition
  }
  
  //MARK: - Game logic
  
  private func checkIfVineCut(withBody body: SKPhysicsBody) {
    
  }
  
  private func switchToNewGame(withTransition transition: SKTransition) {
    
  }
  
  //MARK: - Audio
  
  private func setUpAudio() {
    
  }
}

extension GameScene: SKPhysicsContactDelegate {
  override func update(_ currentTime: TimeInterval) {
    
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    
  }
}

