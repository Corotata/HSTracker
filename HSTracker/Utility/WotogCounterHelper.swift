//
//  WotogCounterHelper.swift
//  HSTracker
//
//  Created by Benjamin Michotte on 28/04/16.
//  Copyright © 2016 Benjamin Michotte. All rights reserved.
//

import Foundation

class WotogCounterHelper {
    static var playerCthun: Entity? {
        return Game.shared.player.playerEntities
            .firstWhere({ $0.cardId == CardIds.Collectible.Neutral.Cthun })
    }

    static var playerCthunProxy: Entity? {
        return Game.shared.player.playerEntities
            .firstWhere({ $0.cardId == CardIds.NonCollectible.Neutral.Cthun })
    }

    static var playerYogg: Entity? {
        return Game.shared.player.playerEntities
            .firstWhere({ $0.cardId == CardIds.Collectible.Neutral.YoggSaronHopesEnd })
    }

    static var playerNzoth: Entity? {
        return Game.shared.player.playerEntities
            .firstWhere({ $0.cardId == CardIds.Collectible.Neutral.NzothTheCorruptor })
    }

    static var playerArcaneGiant: Entity? {
        return Game.shared.player.playerEntities
            .firstWhere({ $0.cardId == CardIds.Collectible.Neutral.ArcaneGiant
                && $0.info.originalZone != nil })
    }

    static var opponentCthun: Entity? {
        return Game.shared.opponent.playerEntities
            .firstWhere({ $0.cardId == CardIds.Collectible.Neutral.Cthun })
    }

    static var opponentCthunProxy: Entity? {
        return Game.shared.opponent.playerEntities
            .firstWhere({ $0.cardId == CardIds.NonCollectible.Neutral.Cthun })
    }

    static var playerSeenCthun: Bool {
        return Game.shared.playerEntity?.has(tag: .seen_cthun) ?? false
    }

    static var opponentSeenCthun: Bool {
        return Game.shared.opponentEntity?.has(tag: .seen_cthun) ?? false
    }

    static var playerSeenJade: Bool {
        return Game.shared.playerEntity?.has(tag: .jade_golem) ?? false
    }

    static var playerNextJadeGolem: Int {
        let jade = Game.shared.playerEntity?[.jade_golem] ?? 0
        return playerSeenJade ? min(jade + 1, 30) : 1
    }

    static var opponentSeenJade: Bool {
        return Game.shared.opponentEntity?.has(tag: .jade_golem) ?? false
    }

    static var opponentNextJadeGolem: Int {
        let jade = Game.shared.opponentEntity?[.jade_golem] ?? 0
        return opponentSeenJade ? min(jade + 1, 30) : 1
    }

    static var cthunInDeck: Bool? {
        return deckContains(cardId: CardIds.Collectible.Neutral.Cthun)
    }

    static var yoggInDeck: Bool? {
        return deckContains(cardId: CardIds.Collectible.Neutral.YoggSaronHopesEnd)
    }

    static var arcaneGiantInDeck: Bool? {
        return deckContains(cardId: CardIds.Collectible.Neutral.ArcaneGiant)
    }

    static var nzothInDeck: Bool? {
        return deckContains(cardId: CardIds.Collectible.Neutral.NzothTheCorruptor)
    }

    static var showPlayerCthunCounter: Bool {
        return Settings.instance.showPlayerCthun && playerSeenCthun
    }

    static var showPlayerSpellsCounter: Bool {
        guard Settings.instance.showPlayerSpell else { return false }

        return (yoggInDeck != nil && (playerYogg != nil || yoggInDeck == true))
                || (arcaneGiantInDeck != nil
                    && (playerArcaneGiant != nil || arcaneGiantInDeck == true))
    }

    static var showPlayerDeathrattleCounter: Bool {
        return Settings.instance.showPlayerDeathrattle
            && nzothInDeck != nil && (playerYogg != nil || nzothInDeck == true)
    }
    
    static var showPlayerGraveyard: Bool {
        return Settings.instance.showPlayerGraveyard
    }

    static var showPlayerJadeCounter: Bool {
        return Settings.instance.showPlayerJadeCounter && playerSeenJade
    }

    static var showOpponentJadeCounter: Bool {
        return Settings.instance.showOpponentJadeCounter && opponentSeenJade
    }

    static var showOpponentCthunCounter: Bool {
        return Settings.instance.showOpponentCthun && opponentSeenCthun
    }

    static var showOpponentSpellsCounter: Bool {
        return Settings.instance.showOpponentSpell
    }

    static var showOpponentDeathrattleCounter: Bool {
        return Settings.instance.showOpponentDeathrattle
    }
    
    static var showOpponentGraveyard: Bool {
        return Settings.instance.showOpponentGraveyard
    }

    private static func deckContains(cardId: String) -> Bool? {
        return Game.shared.currentDeck?.cards.any({ $0.id == cardId })
    }
}
