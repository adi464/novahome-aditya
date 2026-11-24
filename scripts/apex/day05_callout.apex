// Day 5: call the public mock API through the Named Credential and print one record
HttpRequest req = new HttpRequest();
req.setEndpoint('callout:NovaHome_Mock_API/users/1');   // base URL lives in the Named Credential
req.setMethod('GET');
req.setTimeout(20000);
HttpResponse res = new Http().send(req);
System.debug(LoggingLevel.ERROR, 'DAY5 STATUS: ' + res.getStatusCode() + ' ' + res.getStatus());
Map<String, Object> user = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
Map<String, Object> address = (Map<String, Object>) user.get('address');
System.debug(LoggingLevel.ERROR, 'DAY5 RECORD: id=' + user.get('id') + ' | name=' + user.get('name')
    + ' | email=' + user.get('email') + ' | city=' + address.get('city'));
