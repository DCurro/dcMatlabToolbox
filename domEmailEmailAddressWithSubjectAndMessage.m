function domEmailEmailAddressWithSubjectAndMessage( emailAddress, subjectString, messageString )
    system('echo "example message" | mailx -s "test email" domenic.curro@gmail.com')
    
    systemCommand = ['echo ',messageString,' | mailx -s "',subjectString,'" ',emailAddress];
    system(systemCommand);
end

