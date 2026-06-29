---
layout: post
date: 2023-06-03
title: A quick approach to assess the security of a system
excerpt: "This article discusses a method for quickly assessing the security of a system before using more comprehensive methods like penetration testing."
tags: Penetration_Test_Scoping Threat_Modelling Design_Security_Review
---

When it comes to assessing the security of a system, many methods can be used, such as penetration testing, vulnerability assessments and threat modelling. Depending on the method, you can get an overview of security issues and the strength of controls of the system. However, these methods require prior planning and also take a bit of time. The question is, how would you assess the security of a system before using such methods? In my case, when I quickly need to assess the security of a system before using such a method, I generally check the implementation of the following areas/principles within the system:

1. Defence in Depth principle
2. Segregation of duties and least privileges
3. Data encryption in transit and at rest
4. Handling sensitive data and information
5. Patching and version control
6. Used technology and architecture
7. Security testing and compliance requirements
8. Logging and monitoring
9. Business continuity plan

The purpose of this article is to provide an overview of how to quickly go through a system design and identify security issues using these nine areas. This approach requires a fair bit of knowledge related to security best practices and the ability to think outside the box. However, in this article I will not write about security best practices in detail but will use some of them when describing the examples. Also, this approach is not an alternative to much better methods, such penetration testing.

This approach can be used in any design, regardless of size. All you have to do is divide the design into smaller segments. To get the information that you need, you can use many techniques, such as checking architecture notes, design diagrams, and speaking with relevant people. You do not have to go deep and answer every single question. It's all about getting an idea.

It is also important to note that this approach will not reveal all the security issues by itself but will help to reveal them using other methods. For example, this approach provides a better idea of what to test and where to focus. Hence, this can be used to plan and combine various security assessment methods to get better results.

Before getting into the example, I would like to point out that it is always good to assess security after understanding the business model. This will help to understand how security recommendations will affect the cost and usability of the system. Even though this is not 100% important when it comes to technical reviews, it would give an idea about what kind of security is best for the system.

<br>

## An example use of this approach

To describe, I will use the following scenario and its simple web application diagram. But this approach is not limited to web applications and can be used in different scenarios.

![image](/images/simple_solution.svg)

A business uses an internally built e-commerce web application. This web application is hosted on an Ubuntu server that is situated on the company network. The files that users upload, such as product images, are stored on a file server that is separate from the web application server. The database for the web application is also hosted on a separate server.

<br>

### 1. Defence in Depth principle

Defence in depth is a very important cybersecurity strategy that involves using multiple layers of security measures to protect valuable information and systems. Simply put, what will happen if the control number 1 fails? Should we implement control number 2 to avoid a threat actor getting into a system if control number 1 fails? Multifactor authentication is a good example of this. However, the defence in depth principle covers a large area of protective measures, including some of the main areas that I have mentioned, such as data encryption, segregation of duties. But I would like to weight those separately mentioned ones a bit more and keep them on my list.

How would you use this in our example? The following questions are some of the areas that I would mainly focus on:
- Does the web application use a Web Application Firewall (WAF) to block malicious attempts?
- Does the web application use a Denial of Service (DoS) protection to avoid DoS attacks?
- Does the network use segmentation to avoid threat actors getting into other network devices, if they manage to compromise the web server?
- Can internal network users directly connect to the database or the file share?
- Can external network users directly connect to the database or the file share?
- Can the threat actor directly connect to the web server using technologies such as RDP or SSH via internet?
- Does the network use an Intrusion Prevention System or similar ways to detect malicious traffic to block malicious connections if the web server gets compromised?
- Does the web application use Multifactor Authentication (MFA) to prevent unauthorised access via compromised passwords?
- Does the web application destroy the session immediately when the user is idle for a certain period of time, or directly log out?
- Does the database server contain other databases with sensitive data that are not related to this web application?

<br>

### 2. Segregation of duties and least privileges

Segregation of duties is a principle or practise that involves dividing critical tasks and responsibilities among different individuals within an organisation. The purpose is to establish checks and balances, reduce the risk of errors or fraud, and enhance security. The key concept behind segregation of duties is that no single person should have complete control over a process or access to all necessary resources. By distributing tasks among multiple individuals, the organisation creates a system of mutual accountability and oversight. Also, users should only have the required amount of privileges to do assigned tasks, as mentioned in the least privileges principle.

How would you use this in our example? The following questions are some of the areas that I would mainly focus on:
- Does the web application have different roles for users? If so, what type of method does the web application use? for example, role based access control. 
- What type of access does the web application provide to each user role? For example, will the web application admin user be able to edit web application files (for example, PHP files) that are on the server using the web application admin console.
- Does the approval for production come from the same developer who developed the web application? *This is a very open-ended question, and it is important to understand the process first.*
- Can the web application database user directly communicate with the database as an administrator?
- Does the web application use root user access within the server?
- Does the file share use a separate user account, or does it provide a web application server with admin user access to save and retrieve files?
- Who has access to sensitive data/information?

<br>

### 3. Data encryption in transit and at rest

The security of the stored data within a system is always one of the main priorities in security. In this section, the focus is on how threat actors would gain access to data and what they could do if they got access.

How would you use this in our example? The following questions are some of the areas that I would mainly focus on:
- Does the web application save passwords? If so, what type of hashing method does it use?
- Does the web application deal with sensitive information, such as Personal Identifiable Information (PII)? If so, how does the web application reduce the impact if threat actors get access to this data? Does it use encryption?
- Does the web application and other components (including servers) use TLS to encrypt the data transfer? This includes all the protocols that the web application and its components use.
- Do the servers use OS-level encryption?

<br>

### 4. Handling sensitive data and information

A system could contain different types of sensitive data, such as credentials to other servers, Personal Identifiable Information (PII) and API keys. This section focuses on, apart from encryption, what other methods are in use to protect this information.

How would you use this in our example? The following questions are some of the areas that I would mainly focus on:
- Where do the web application and the database store data? Is it within the same country or region? If not, what type of legislation could be applied to the data? This includes laws such as privacy laws and data retention laws.
- Does the web application use technologies such as secret management systems to protect sensitive technical information such as passwords, certificates and API keys.
- Does the web application anonymise the data when it comes to other uses, such as data analysis, or further development?

<br>

### 5. Patching and version control

Patching is a vital process in security management. Vulnerabilities could occur in any system, regardless of how secure it was built. An issue in a small library that the software uses can lead to massive cyberattacks. Knowing how this process would work and what areas to focus on is important to identifying the security of the system.
On the other hand, version control also plays a major role in security management. We should know how secure the new version is before it gets into production or environments that are open to the world.

How would you use this in our example? The following questions are some of the areas that I would mainly focus on:
- What is the patch management process?
- Who approves new versions before publishing them? Do they go through security testing?
- What is the process for third-party module management?
- How does development happen? Is it open to the world? If so, who accepts the changes and requests? What is the process?
- What security practises does the development team use in their environments?

<br>

### 6. Used technology and architecture

Mapping the technology and architecture to the current environment of the organisation is also important. The security team must know the capabilities of the organisation. If the system is SaaS, they should know what the visible processes are, whether they satisfy the required SLAs, etc. Without going too deep, we can still get a fair amount of ideas about security by understanding the main areas.

How would you use this in our example? The following questions are some of the areas that I would mainly focus on:
- What technologies does the web application use? Are they at the end of life? Or are they very new to the world?
- Does the organisation have the capability to manage those technologies? If not, what is the management process?
- Why does it use these particular technologies when there are better alternatives?

<br>

### 7. Security testing and compliance requirements

Another important area to focus on is whether this system has gone through security testing or not. If so, how and what were the findings?

How would you use this in our example? The following questions are some of the areas that I would mainly focus on:
- Did the web application use static code analysis during the development phase?
- Did the web application go through a penetration test before getting into production?
- Do the servers go through routine vulnerability scanning?
- What are the compliance requirements related to this application? For example, ISO 27001 or PCI DSS

<br>

### 8. Logging and monitoring

Logging and monitoring are essential for maintaining the security of systems and applications. They enable the detection of suspicious activities, security breaches, or unauthorised access attempts. By monitoring logs for security-related events, organisations can respond promptly to potential threats and take appropriate actions to mitigate risks. Additionally, logging is often required for compliance with industry regulations and standards, enabling organisations to demonstrate adherence to security and data protection requirements.

How would you use this in our example? The following questions are some of the areas that I would mainly focus on:
- Does the web application log the data that is required for security purposes?
- Do these logs go to a Security Information and Event Management tool (SIEM) or similar?
- Are these logs being regularly monitored?

<br>

### 9. Business continuity plan

Business continuity plan in cybersecurity is crucial to ensure business continuity and minimise the impact of cyber threats. It enables quick system restoration, data recovery, and patching, while facilitating effective incident response and forensics. Compliance with legal obligations and insurance requirements further emphasises the importance of business continuity plan in safeguarding organisations against cyber incidents.

How would you use this in our example? The following questions are some of the areas that I would mainly focus on:
- What is the Maximum Tolerable Downtime (MTD), Recovery Time Objective (RTO), and Recovery Point Objective (RPO) for this application?
- What is the disaster recovery process? Does it use a hot site? If so, what is the testing process?
- What is the backup process and data retention policy?

<br>

## Summary

The article discusses a method for quickly assessing the security of a system before using more comprehensive methods like penetration testing. It outlines the following nine areas/principles to evaluate:

1. Defence in depth,
2. Segregation of duties,
3. Data encryption,
4. Handling sensitive data,
5. Patching and version control,
6. Technology and architecture,
7. Security testing and compliance requirements,
8. Logging and monitoring,
9. Business continuity plan.

The approach involves dividing the system design into smaller segments and asking specific questions related to each area. While this method does not reveal all security issues, it helps identify areas for further assessment and planning or to get an idea of the state of security.

