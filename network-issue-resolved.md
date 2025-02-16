# Network Issue Resolved: AKS Pods Cannot Communicate with External Services

### **Symptoms:**
- Pods could access other pods within the same cluster.
- Pods could not access external services (e.g., external APIs, websites).
- DNS resolution within pods was not working for external services.

---

### **Investigation Steps:**

#### **Step 1: Verify Pod Network Configuration**

Started by checking the configuration of the pod's network by running the below command:

```bash
kubectl describe pod <pod-name> -n <namespace>
```

* The pod was assigned an internal IP (e.g., 10.244.0.10).
* No network policies were identified that would directly block external access.
* The pod could communicate with other pods within the cluster.

#### **Step 2: Check Network Security Group (NSG) and Azure Firewall Rules**
* Then investigated if any Network Security Groups (NSGs) or Azure Firewall rules might be blocking outbound traffic from the AKS subnet.
* Checked the NSG rules for the subnet in which the AKS cluster resides. Specifically, looked for any outbound restrictions.
* Also reviewed the Azure Firewall configuration to ensure there were no outbound restrictions that would block external traffic.
* There was an outbound NSG rule blocking traffic on certain ports (e.g., HTTP/HTTPS), which affected external communication from the AKS pods.
Azure Firewall had no blocking rules, but the NSG configuration was the root cause.


### **Resolution Steps:**

Updated the NSG rules for the AKS subnet to allow outbound traffic for HTTP/HTTPS (ports 80 and 443) to external services. This involved allowing traffic to the internet and adjusting the outbound rules to unblock any port restrictions that were previously in place.

* Go to the Azure portal.
* Navigate to Networking > Network Security Groups (NSG).
* Modify the Outbound Rules for the subnet where AKS is deployed.
* Ensure ports 80 (HTTP) and 443 (HTTPS) are open for outbound traffic.
* Allow traffic to any destination (*).


### **Conclusion:**
Issue: AKS pods were unable to communicate with external services due to DNS resolution issues and outbound network restrictions.

Root Cause: Misconfigured NSG outbound rules that were blocking traffic to external services.

Resolution: Updated NSG rules to allow outbound HTTP/HTTPS traffic. Tested and confirmed that pods can now communicate with external services.
