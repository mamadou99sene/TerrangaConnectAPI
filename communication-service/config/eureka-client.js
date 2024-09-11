const Eureka = require('eureka-js-client').Eureka;

const eureka = new Eureka({
    instance: {
        app: 'communication-service',
        hostName: 'localhost',
        ipAddr: '127.0.0.1',
        port: {
            '$': 3003,
            '@enabled': true,
        },
        vipAddress: 'communication-service',
        dataCenterInfo: {
            '@class': 'com.netflix.appinfo.InstanceInfo$DefaultDataCenterInfo',
            name: 'MyOwn',
        },
    },
    eureka: {
        host: 'localhost',
        port: 8761,
        servicePath: '/eureka/apps/',
    },
});

module.exports = eureka;