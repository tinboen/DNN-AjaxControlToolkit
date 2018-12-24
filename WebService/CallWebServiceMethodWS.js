// CallWebServiceMethods.js

// This function calls the Web service method without 
// passing the callback function. 
function GetNoReturn()
{
    Samples.AspNet.CallWebServiceMethodWS.GetServerTime();
    alert("This method does not return a value.");
    
}


// This function calls the Web service method and 
// passes the event callback function.  
function GetTime()
{
    Samples.AspNet.CallWebServiceMethodWS.GetServerTime(
    SucceededCallback);
    
}


// This function calls the Web service method 
// passing simple type parameters and the 
// callback function  
function Add(a,  b)
{
    Samples.AspNet.CallWebServiceMethodWS.Add(a, b, 
    SucceededCallback);
}

// This function calls the Web service method 
// that returns an XmlDocument type.  
function GetXmlDocument() 
{
    Samples.AspNet.CallWebServiceMethodWS.GetXmlDocument(
        SucceededCallbackWithContext, FailedCallback,
        "XmlDocument")
}

// This function calls a Web service method that uses
// GET to make the Web request.
function MakeGetRequest() 
{

    Samples.AspNet.CallWebServiceMethodWS.EchoStringAndDate(
        new Date("1/1/2007"), " Happy",
        SucceededCallback, 
        FailedCallback, "HappyNewYear");

}

// This is the callback function invoked if the Web service
// succeeded.
// It accepts the result object, the user context, and the 
// calling method name as parameters.
function SucceededCallbackWithContext(result, userContext, methodName)
{
    var output;
    
    // Page element to display feedback.
    var RsltElem = document.getElementById("ResultId");
    
    var readResult;
    if (userContext == "XmlDocument")
	{
	
	    if (document.all) 
	        readResult = 
		        result.documentElement.firstChild.text;
		else
		    // Firefox
		   readResult =
		        result.documentElement.firstChild.textContent;
		
	     RsltElem.innerHTML = "XmlDocument content: " + readResult;
	}
    
}

// This is the callback function invoked if the Web service
// succeeded.
// It accepts the result object as a parameter.
function SucceededCallback(result, eventArgs)
{
    // Page element to display feedback.
    var RsltElem = document.getElementById("ResultId");
    RsltElem.innerHTML = result;
}


// This is the callback function invoked if the Web service
// failed.
// It accepts the error object as a parameter.
function FailedCallback(error)
{
    // Display the error.    
    var RsltElem = 
        document.getElementById("ResultId");
    RsltElem.innerHTML = 
    "Service Error: " + error.get_message();
}

// This function calls the Web service method 
// passing simple type parameters and the 
// callback function  
function ShowCurrentTime(a, b) {
    var txtUserName = document.getElementById("txtUserName");
    var RsltElem = Samples.AspNet.CallWebServiceMethodWS.GetCurrentTime(txtUserName);
    alert(RsltElem);

}



if (typeof(Sys) !== "undefined") Sys.Application.notifyScriptLoaded();
