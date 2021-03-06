
import Quick
import Nimble

@testable import SwiftAudio

class SimpleAudioPlayerTests: QuickSpec {
    override func spec() {
        describe("A SimpleAudioPlayer") {
            var player: SimpleAudioPlayer!
            beforeEach {
                player = SimpleAudioPlayer()
                player.automaticallyWaitsToMinimizeStalling = false
                player.bufferDuration = 0.0001
                player.volume = 0
            }
            
            describe("its state", {
                it("should be idle", closure: {
                    expect(player.playerState).to(equal(AudioPlayerState.idle))
                })
                
                context("when loading an item with playeWhenReady: false", {
                    beforeEach {
                        try? player.load(item: Source.getAudioItem(), playWhenReady: false)
                    }
                    it("should eventually be ready", closure: {
                        expect(player.playerState).toEventually(equal(AudioPlayerState.ready))
                    })
                })
                
                context("when loading an item with playWhenReady: true", {
                    beforeEach {
                        try? player.load(item: Source.getAudioItem(), playWhenReady: true)
                    }
                    it("should eventually be playing", closure: {
                        expect(player.playerState).toEventually(equal(AudioPlayerState.playing))
                    })
                })
            })
        }
    }
}
