module ApplicationHelper
    def getAuthUrl(connection: 'Username-Password-Authentication')
        return sprintf("/auth/auth0?connection=%s",connection)    
    end
end
