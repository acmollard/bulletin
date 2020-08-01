require 'rubygems'
require 'net/ldap'

class LdapAuthorize
    def authorize
        ldap = Net::LDAP.new
        ldap.host = "ldap.duke.edu"
        base = "dc=duke,dc=edu"
        ldap.port=389
        if ldap.bind
            puts "authentication succeeded"
        else
            puts "authentication failed"
        end
        puts "enter netid: "
        netid = gets.chomp()
        filter = Net::LDAP::Filter.equ("uid", netid)
        
        result=ldap.search(:base => base, :filter => filter)
        if result.empty?
            puts "NO USER FOUND"
        else
            ldap.search(:base=>base, :filter => filter) do |entry|
                puts "DN: #{entry.dn}"
                entry.each do |attribute, values|
                    values.each do |value|
                        puts "#{attribute} --->#{value}"
                    end
                end
            end

            puts "*"*25
            
            information = result.pop
            affiliation = information["edupersonaffiliation"]

            if affiliation.include? 'staff'
                puts "You are authorized!"
            else
                puts "Not authorized!"
            end
        end
    end
end