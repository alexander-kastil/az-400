import { app, HttpRequest, HttpResponseInit, InvocationContext } from "@azure/functions";
import { Param } from '../param';

export async function convertTo(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
    context.log(`Http function processed request for url "${request.url}"`);

    const body = await request.text();
    const param: Param = JSON.parse(body);
    const fixerKey = process.env["FixerKey"];

    const response = await fetch(`http://data.fixer.io/api/latest?access_key=${fixerKey}&base=EUR&symbols=${param.currency}`);
    const responseJson = await response.json();
    const rate = responseJson.rates[param.currency];
    const convertedAmount = rate * param.amount;

    return { body: `Result: ${convertedAmount}!` };
};

app.http('convertTo', {
    methods: ['POST'],
    authLevel: 'anonymous',
    handler: convertTo
});
