//
//  KSUTweetAPIConstants.swift
//  Grubshare
//
//  Created by Reagan Wood on 12/18/17.
//  Copyright © 2017 RW Apps. All rights reserved.
//

import Foundation

extension KSUTweetClient {
    
    struct Constants {
        static let CoreTwitterAPIURL = "https://api.twitter.com/1.1/statuses/user_timeline.json?"
        static let ApiScheme = "https"
        static let ApiHost = "api.twitter.com"
    }
    
    struct UserMethods {
        struct GET {
            static let tweets = "/1.1/statuses/user_timeline.json"
        }
        
        struct POST {
            static let users = "/users"
            static let friends = "/friends"
            static let phones = "/phones"
        }
        
        struct PUT {
            static let users = "/users"
            static let friends = "/friends"
        }
    }
    
    struct TwitterAPIResponseKeys {
        static let ID = "id"
        static let Cognito_ID = "cognito_id"
        static let FirstName = "first_name"
        static let LastName = "last_name"
        static let BirthDate = "birthdate"
        static let Email = "email"
        static let PhoneNumber = "phone_number"
        static let PictureULR = "picture"
        static let FriendRequestedStatus = "status"
        static let InvitedFriendsDictionary = "invited_friends"
        static let AcceptedFriendsDictionary = "friends"
        static let InvitedFriendsRelationshipInfo = "Friendships"
        static let InvitedFriendsFriendshipsArrayUserID = "user_id"
        static let InivitedFriendsFriendshipStatus = "status"
        static let FriendsYouHaveBeenInvitedBy = "friend_invites"
        static let FriendshipRequestResponseStatus = "status"
        static let IsUserInSquirrelitSystem = "is_user"
    }
    
    struct TwitterAPIResponseValues {
        static let FriendshipRequestAccepted = "Accepted"
        static let FriendshipRequestDeclined = "Declined"
    }
    
    struct TwitterAPIParameterKeys {
        static let FriendRequestStatusKey = "status"
        static let PhoneNumber = "phone_number"
        static let Favorite = "favorite"
        static let FirstName = "first_name"
        static let LastName = "last_name"
    }
    
    struct TwitterAPIParameterValues {
        static let APIKey = ""
        static let FriendRequestAcceptedValue = "Accepted"
        static let FriendRequestDeniedValue = "Declined"
        static let NotFavoriteFriend = "false"
        static let FavoriteFriend = "true"
    }
}

