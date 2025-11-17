# Angular Continuous Integration

Samples are included in the Angular repo available at [angular-devops](https://github.com/alexander-kastil/angular-devops)

Requires [Node 16](https://nodejs.org/en/download/releases/) and Angular

Manual Steps:

```
npm i -g @angular/cli
```

Create proj:

```
ng new ngBuild
ng s -o
```

Manual Build:

```
npm i
ng build -c production
```

Show `deploy/angular-ci.yml`