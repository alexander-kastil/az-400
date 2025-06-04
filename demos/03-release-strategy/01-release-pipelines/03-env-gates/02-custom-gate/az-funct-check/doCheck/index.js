module.exports = async function (context, req) {
    context.log('JavaScript HTTP trigger function processed a request.');

    // Mocking use of Az DevOps REST Api https://docs.microsoft.com/en-us/rest/api/azure/devops/?view=azure-devops-rest-6.1, any other source or even forwarding approval to teams using an adaptive card
    const succeed = req.body && req.body.succeed;
   
    if(succeed==true){
        context.res = {
            status: 200, 
            body: "all fine"
        };
    }else{
        context.res = {
            status: 425, 
            body: "too early"
        };
    }

}