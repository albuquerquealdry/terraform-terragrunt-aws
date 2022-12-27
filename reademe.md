ingress:
  enabled: true
  annotations: 
    kubernetes.io/ingress.class: nginx
  rules:
  - http:
      paths:
        - path: /
          pathType: Prefix
          backend:
            service:
              name: kubernetes-dashboard
              port: 
                number: 443