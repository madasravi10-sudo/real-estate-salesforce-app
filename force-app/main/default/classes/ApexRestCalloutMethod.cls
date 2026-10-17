public class ApexRestCalloutMethod {
    public static void GetUsersFromExternalSystems(){
        ////HTTP httpObj = new HTTP();
       // HTTPRequest req = new HTTPRequest();
        //req.setendpoint('https://reqres.in/api/users');
        //req.setHeader('content-type','application/Json');
        ////req.setMethod('GET');
        //HTTPResponse res = new HTTPResponse();
         //res=httpobj.send(req);
        //system.debug('@@@@response body___'+res.getBody()); *///
        HTTP httpObj = new HTTP();
        HTTPRequest req = new HTTPRequest();
         req.setendpoint('https://reqres.in/api/users');
        req.setHeader('content-type','application/Json');
        req.setMethod('POST');
        req.setbody('{"name":"vegi","job":"srikanth"}');
         HTTPResponse res = new HTTPResponse();
         res=httpobj.send(req);
        system.debug('@@@@response body___'+res.getBody());
}
}