<%@ Import Namespace="WebRole1" %>
<%@ Import Namespace="WebRole1.Helpers" %>
<%@ Page Title="Sponsors" Language="C#" MasterPageFile="~/SitePage.master" AutoEventWireup="true" CodeBehind="Sponsors.aspx.cs" Inherits="WebRole1.Sponsors" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
	<section id="sponsorsWrapper">
		<section class="row banner">
			<article>
				<img src="Images/Sponsors/qoutesSM.png" />
				<h1>Sponsors</h1>
			</article>
		</section>
		<section class="row">
			<h4 class="panel">
				The Lync Conference 2014 exhibit hall is currently filled to capacity. Please see our list of sponsors below and check back 
				frequently for more information. We are no longer accepting sponsorship or exhibitor applications.
			</h4>
		</section>
		<%
			List<Sponsor> diamondSponsors = new List<Sponsor>(){ 
				new Sponsor(){
					Name = "HP",
					ImageName = "hp",
					URL = "http://h71028.www7.hp.com/enterprise/cache/561534-0-0-0-121.html",
					Description = @"<p>HP creates new possibilities for technology to have a meaningful impact on people, businesses, governments and society. With the broadest technology portfolio spanning printing, personal systems, software, services and IT infrastructure, HP delivers solutions for customers' most complex challenges in every region of the world. More information about HP (NYSE: HPQ) is available at <a href='http://www.hp.com' target='_blank'>http://www.hp.com</a>.</p>"
				}
			};
			List<Sponsor> platinumSponsors = new List<Sponsor>(){  
				new Sponsor(){
					Name = "AT&T",
					ImageName = "att",
					URL = "http://www.att.com/msftlync",
					Description = @"<p>Spanning one of the broadest service continuums in the industry, AT&T has expertise in Unified Communications, application management, managed hosting, cloud computing, mobility, voice and IP networking services and more to support varied business needs.  A member of the Microsoft Partner Network, AT&T has over 10 years' experience managing Microsoft applications with competencies in Portals, Unified Communications and Collaboration. Look to AT&T to manage and host your applications throughout their lifecycle, providing you with flexibility, global reach and responsive support that can help you to maximize your business and strategic value. Visit <a href='http://www.att.com/msftlync' target='_blank'>www.att.com/msftlync</a> for more information.</p>"
				},  
				new Sponsor(){
				    Name = "Dell",
				    ImageName = "dell",
				    URL = "http://www.dell.com",
				    Description = @"<p>Dell’s Unified Communications Solutions provide real-time productivity for today’s modern work style. Our award winning Global services team has expertise in every area of voice and messaging, providing consulting, deployment and support for hundreds of thousands of seats worldwide. Dell solutions for Unified Communications deliver the power of Microsoft UC software combined with our intelligent infrastructure, software, and management tools to simplify, streamline, and support customer environments.   Dell helps customers achieve more by providing efficient, modular solutions based on our award winning servers and storage to power the application; networking solutions to deliver Quality of Service and security; and end user devices that connect people to each other and information.</p>"
				},  
				new Sponsor(){
					Name = "Sonus",
					ImageName = "sonus",
					URL = "http://www.sonus.net/lync/ ",
					Description = @"<p>Sonus is a leader in IP networking with proven expertise in delivering secure, reliable and scalable next-generation infrastructure and subscriber solutions. With customers in over 50 countries across the globe and over a decade of experience in transforming networks to IP, Sonus has enabled service providers and enterprises to capture and retain users and generate significant ROI. Sonus products include session border controllers, policy/routing servers, subscriber feature servers and media and signaling gateways. Sonus products are supported by a global services team with experience in design, deployment and maintenance of some of the world's largest and most complex IP networks. For more information, call 1-855-GO-SONUS – <a href='http://www.sonus.net' target='_blank'>www.sonus.net</a>.</p>"
				},
				new Sponsor(){
				    Name = "Polycom",
				    ImageName = "Polycom",
				    URL = "http://www.polycom.com/microsoft",
				    Description = @"<p>Polycom is the global leader in open, standards-based unified communications and collaboration (UC&C) solutions for voice and video collaboration, trusted by more than 415,000 customers around the world. Polycom solutions are powered by the Polycom® RealPresence® Platform, comprehensive software infrastructure and rich APIs that interoperate with the broadest set of communication, business, mobile and cloud applications and devices to deliver secure face-to-face video collaboration in any environment. Polycom and its ecosystem of over 7,000 partners provide truly unified communications solutions that deliver the best user experience, highest multi-vendor interoperability, and lowest TCO. Visit <a href='http://www.polycom.com/microsoft' target='_blank'>www.polycom.com</a> or connect with us on <a href='http://twitter.com/@Polycom' target='_blank'>Twitter</a>, <a href='http://www.facebook.com/Polycom' target='_blank'>Facebook</a>, and <a href='http://www.linkedin.com/groups?mostPopular=&gid=1953916' target='_blank'>LinkedIn</a> to learn how we’re pushing the greatness of human collaboration forward.</p>"
				}
			};
			List<Sponsor> goldSponsors = new List<Sponsor>(){ 
				new Sponsor(){
					Name = "Aruba Networks",
					ImageName = "aruba",
					URL = "http://www.arubanetworks.com/solutions/lync",
					Description = @"<p>Aruba Networks is a leading provider of next-generation, Lync certified Wi-Fi and networking solutions for the mobile enterprise. The company's Virtual Enterprise (MOVE) architecture unifies wireless, wired, and remote access infrastructures, and is designed for both Lync Server and Office 365 applications in enterprises of all sizes. This unified approach to network access securely addresses Bring Your Own Device (BYOD) requirements, dramatically improving productivity and lowering capital and operational costs  Listed on the NASDAQ and Russell 2000® Index, Aruba is based in Sunnyvale, California, and has operations throughout the Americas, Europe, Middle East, Africa and Asia Pacific regions. To learn more, visit Aruba at <a href='http://www.arubanetworks.com/solutions/lync' target='_blank'>www.arubanetworks.com/solutions/lync</a>.</p>"
				},
       			new Sponsor(){
					Name = "Crestron",
					ImageName = "crestron",
					URL = "https://www.crestron.com",
					Description = @"<p>Crestron takes Microsoft Lync® from the desktop to the conference room with the introduction of Crestron RL™.  
                                       Crestron RL enables one touch control of all technology in the conference room. Crestron RL communicates with 
                                       Crestron Fusion™ software, which collects and reports valuable usage data about all systems and activities to intelligently
                                       manage the room, and provide remote help desk support from any web-enabled device.
									</p>
									<p>For 40 years Crestron has been the world's leading manufacturer of advanced control and automation systems. In addition to 
                                       its worldwide headquarters in New Jersey, Crestron has 91 sales and support offices worldwide. 
									</p>"
				},
				new Sponsor(){
				   Name = "Intelepeer",
				    ImageName = "intelepeer",
				    URL = "http://www.intelepeer.com/",
				   Description = @"<p>IntelePeer, Inc. is a leading provider of on-demand, cloud-based communications services for enterprises. The patented IntelePeer CloudWorx™ software platform, leveraging the scale and reach of the Cloud, delivers multi-modal communications, including voice, video, unified communications, and other rich-media with high quality and reliability. IntelePeer enables customers to rapidly and cost-effectively transition from legacy telecommunications networks to IP-based communications, with little or no additional capital expenditures. As a result, IntelePeer customers can improve their return on investment on communications equipment and services.</p>"
				},  
				new Sponsor(){
					Name = "Jabra",
					ImageName = "jabra",
					URL = "http://www.jabra.com",
					Description = @"<p>Jabra is a Microsoft Gold Communications Partner and 2013 Communication Partner of the Year Finalist. Jabra 
										makes a full line of audio endpoints that are optimized for Microsoft® Lync™ and Lync Online™.  Jabra 
										devices are tested by Microsoft to offer a rich and integrated audio experience.  With Jabra, users can 
										derive the full business productivity and efficiencies that they expect through enhanced voice collaboration 
										based on simplicity.
									</p>
									<p>Jabra has support programs and offers to help advance your Lync deployment. Jabra also created Jabra 
										Xpress to help IT staffs manage endpoints.  Jabra Xpress allows IT the ability to manage and configure 
										devices remotely.  Visit Jabra at Lync Con 2014.
									</p>"
				},  
				new Sponsor(){
					Name = "Plantronics",
					ImageName = "Plantronics",
					URL = "http://www.plantronics.com/us/solutions/microsoft/",
					Description = @"<p>Plantronics is a global leader in audio communications. For over 50 years, we’ve created innovative products that allow people to simply communicate. Plantronics enables a superior user experience for Microsoft Lync with audio endpoints that work across platforms, applications and devices, and developer tools to connect Lync communications to critical business applications. Microsoft customers turn to Plantronics for smarter audio devices that connect, collaborate, and engage – bringing technology and people together.</p>"
				}, 
				new Sponsor(){
					Name = "Sennheiser Communications",
					ImageName = "sennheiser",
					URL = "http://www.sennheiser.com/lync",
					Description = @"<p>Sennheiser is one of the world's leading manufacturers of headphones, microphones, wireless transmission systems and high-quality headsets for both business and entertainment.</p><p>Drawing on the electro acoustics expertise of Sennheiser and the leading hearing healthcare specialist William Demant, Sennheiser Communication's wireless and wired headsets for contact centers, offices and Unified Communications professionals are the result of Sennheiser's and William Demant's joint leadership in sound quality, design, wearing comfort and hearing protection.</p>"
				},
				new Sponsor(){
					Name = "snom Technology, inc.",
					ImageName = "snom",
					URL = "http://www.snom-uc-edition.com",
					Description = @"<p>snom technology AG develops and manufactures VoIP telephones and related equipment based on the open standard SIP (Session Initiation Protocol). In 2011, the snom 300 and snom 821 became the first SIP phones to achieve “Qualified for Microsoft Lync” status, Microsoft’s top distinction for interoperability and compatibility with Microsoft Lync. Since then snom has deepened its support of Lync with the UC series of IP phones, and continued to enhance its capabilities. Today snom has one of the fullest portfolios of Lync endpoints in the industry.</p>"
				},
        		new Sponsor(){
					Name = "SPS",
					ImageName = "sps",
					URL = "http://www.spscom.com",
					Description = @"<p>Ensure performance. Increase control. Simplify budgeting.
                                    SPS is a communication systems integrator invested in top-tier, Microsoft-certified talent to ensure that our team is ready to support yours. With experience on Lync deployments supporting up to 35,000 users across a range of industries and public-sector organizations – including some of the largest Lync implementations to date – SPS provides unmatched knowledge and ability to execute. 
                                    All Lync services and support are provided by the highly-capable SPS team of Microsoft specialists, who carry over 90 relevant certifications. And because SPS is a Microsoft Software Assurance Planning Services Provider, you can apply Software Assurance (SA) vouchers to your SPS projects.
                                    As a communications systems integrator, SPS provides a wide range of services covering every phase of your Microsoft Lync project, including project planning, implementation services, and ongoing support and managed-service options to suit your requirements.
                                    </p>"
				},
				new Sponsor(){
					Name = "Unify Square",
					ImageName = "unify",
					URL = "http://www.unifysquare.com",
					Description = @"<p>Founded by former Microsoft Lync product team members with deep insight into the UC market, Unify2 is a leading provider of Unified Communications and Collaboration solutions. Unify2 is one of the largest solution providers for Microsoft Lync worldwide, with more than 40 global Fortune 1000 companies amongst its enterprise customers and nearly 3 million Microsoft Lync users impacted through its products, services and support solutions. Unify2 is a Microsoft Gold Certified Partner and was a finalist in the 2013 Microsoft Partner of the Year Award in Communications.  Learn more at: <a href='http://www.unifysquare.com' target='_blank'>www.unifysquare.com</a>.</p>"
				}
			};
			List<Sponsor> silverSponsors = new List<Sponsor>(){
				new Sponsor(){
					Name = "Actiance",
					ImageName = "actiance",
					URL = "http://www.actiance.com/",
					Description = @"<p>The Actiance platform gives organizations the ability to ensure compliance for all their communication channels. It provides real-time content monitoring, centralized policy management, contextual capture of content and smart archiving which improves the efficiency and cost-effectiveness of eDiscovery and helps protect users from malware and accidental or malicious leakage of information. 
                                        Actiance supports all leading social media, unified communications, collaboration, and IM platforms, including Facebook, LinkedIn, Twitter, Google, Yahoo!, Skype, IBM, Jive, Microsoft, Cisco and Salesforce.com.</p><p>Actiance headquarters are located in Redwood City, California.  For more information, visit <a target='_blank' href='http://www.actiance.com/'>www.actiance.com</a>.</p>"
				},
				new Sponsor(){
					Name = "Arrow",
					ImageName = "arrow",
					URL = "http://www.arrows3.com/",
					Description = @"<p>Arrow S3 is a uniquely-capable total solutions provider specializing in unified communications, voice and data technologies, contact center and network security all while providing our customers with legendary service and support.</p><p>Today’s Information and communications technology offers a very real opportunity for businesses to gain competitive advantage. Arrow S3 offers the world’s best in communications technology – but it’s about more than just technology. Business impact is derived from understanding the business opportunity clearly, setting specific goals and objectives for the technology solution, and expertly applying that correct balance of technology, know how, customization and integration that delivers on those objectives.</p>"
				},
				new Sponsor(){
					Name = "AudioCodes",
					ImageName = "AudioCodes",
					URL = "http://www.audiocodes.com/Microsoft",
					Description = @"<p>AudioCodes, a Microsoft Communications Gold Competency partner, designs, develops and sells AudioCodes One Voice for Lync, a comprehensive portfolio of voice networking technology, professional services and global support, optimized for Microsoft Lync and Exchange Unified Communications solutions. Sold through a global network of highly-trained reseller partner community, AudioCodes One Voice for Lync simplifies the selection, implementation and support of Unified Communications. Whether deployed on-premise or in the cloud, AudioCodes is the One Source for Microsoft-certified voice networking products and services.  To learn more, visit <a href='http://www.audiocodes.com/Microsoft' target='_blank'>http://www.audiocodes.com/Microsoft</a>.</p>"
				},
				new Sponsor(){
					Name = "BT Global ",
					ImageName = "btglobal",
					URL = "http://www.globalservices.bt.com/us/en/home",
					Description = @"<p>For more than 20 years, BT has provided solutions in the U.S. and Canada that help enterprises effectively use technology to drive business growth.  The expertise of our employees enables us to help customers globalize their businesses in innovative and sustainable ways.  Through strategic development, strong alliances and a diverse collection of best practices and methodologies, BT has emerged as a leader in networked IT services providing professional services and consultancy, managed services, and full outsourcing for business and IT transformation.</p>"
				},
				new Sponsor(){
					Name = "Genesys",
					ImageName = "Genesys",
					URL = "http://www.genesyslab.com/products/genesys-smart-link/overview.aspx",
					Description = @"<p>Genesys is a leading provider of customer engagement and contact center solutions. With more than 3,500 customers in 80 countries, Genesys orchestrates more than 100 million customer interactions every day across the contact center and back office, helping companies deliver fast and optimal levels of customer service with a highly personalized cross-channel customer experience. Genesys also prioritizes the flow of work to back office personnel resulting from any customer interaction, internal workflow or business application, optimizing the performance and satisfaction of customer-facing employees across the enterprise.</p>"
				},
				new Sponsor(){
					Name = "CDW",
					ImageName = "cdw",
					URL = "http://www.cdw.com",
					Description = @"<p>CDW is a leading provider of technology solutions to business, government, education and healthcare. A Fortune 500 company, CDW features dedicated account managers who help customers choose the right technology products and services to meet their needs. The company's solution architects offer expertise in designing customized solutions, while its advanced technology engineers assist customers with the implementation and long-term management of those solutions. Areas of focus include software, network communications, notebooks/mobile devices, data storage, video monitors, desktops, printers and solutions such as virtualization, collaboration, security, mobility, data center optimization and cloud computing. CDW was founded in 1984 and employs approximately 6,800 coworkers. For the trailing twelve months ended June 30, 2013, the company generated net sales of more than $10.4 billion. For more information, visit <a href='http://www.CDW.com' target='_blank'>www.CDW.com</a>.</p>"
				}, 
				new Sponsor(){
					Name = "Clarity Consulting",
					ImageName = "clarityConnect",
					URL = "http://connect.claritycon.com/",
					Description = @"<p>Clarity's Unified Communications Practice delivers premier products and solutions that leverage Lync as a communication platform, which allow our clients to significantly reduce costs and complexities within their IT environments. Our premier Lync product, Clarity Connect, is a robust contact center solution built exclusively native to Microsoft Lync. Clarity Connect seamlessly integrates with an existing Lync infrastructure, adding full functionality with one simple, fixed fee per user. Clarity's Unified Communications team can also create solutions that work with Lync's native APIs to bring extended functionality such as enhanced conferencing, broadcast messages, persistent chat solutions, and communication-enabled business processes seamlessly to Lync clients.</p>"
				},  
				new Sponsor(){
					Name = "ComputerTalk",
					ImageName = "compTalk",
					URL = "http://www.computer-talk.com/en/products/contact-center-for-lync",
					Description = @"<p>ComputerTalk is a Microsoft Online Service Advisor with Gold Application Development and Gold Communications competencies. Our ice all-in-one contact center is native to Lync. It is Lync 2013 and 2010 ISV qualified, with speech IVR, recording, web chat & IM, and custom Lync CEBP applications. We provides white label on-premise and cloud-based Unified Communications solutions to distributors around the world, specializing in Lync Enterprise Voice. ComputerTalk is the current Microsoft Canada Communications Partner of the Year IMPACT award Winner. Our cloud data center runs in a PCI-compliant environment handling secure financial transactions. ComputerTalk was founded in 1987 and is headquartered in Richmond Hill, Ontario, Canada.</p>"
				},
				new Sponsor(){
					Name = "DiData",
					ImageName = "dimensionData",
					URL = "https://www.dimensiondata.com/Global/Technologies/Collaborative-Workspace/Pages/What-we-offer.aspx",
					Description = @"<p>Dimension Data believes in the power of technology to transform your organization, make things work better ... and take your business to the next level. Over the last three decades, we've established ourselves as global leader in the provision and management of specialist IT infrastructure solutions and services. With operations in over 50 countries, over 15,000 employees and over 6,000 clients – coupled with our deep understanding of the global business and technology landscape – we help accelerate the achievement of your business goals.</p>"
				},  
				new Sponsor(){
					Name = "Interactive Intelligence",
					ImageName = "interactiveIntel",
					URL = "http://www.inin.com",
					Description = @"<p>Deliberately Innovative All-in-One Communications for Business. Interactive Intelligence is a global provider of unified business communications solutions for contact center automation, unified communications, and business process automation. The company's standards-based all-in-one communications software suite was designed to eliminate the cost and complexity of multi-point systems. Founded in 1994 and backed by more than 5,000 customers worldwide, Interactive Intelligence is an experienced leader in delivering customer value through its on-premise or cloud-based Communications as a Service (CaaS) solutions, both of which include software, hardware, consulting, support, education and implementation. At Interactive Intelligence, it's what we do.</p>"
				},
				new Sponsor(){
					Name = "Logitech",
					ImageName = "Logitech",
					URL = "http://www.logitech.com/lync",
					Description = @"<p>Logitech, a world leader in products that connect people to the digital experiences they care about, has partnered with Microsoft® Lync™ to offer a range of fully-optimized for Lync UC tools that are so intuitive, people actually love to use them, enabling enhanced collaboration and productivity from the desktop to the conference room.</p><p>As one of the first companies to develop unique Lync 2013 features, Logitech enhances the collaboration experience in the richest way. With HD video in a wider field of view, it’s now possible to present from a whiteboard, show a document or conduct a demo in clear view all from your desktop. See who’s talking with intelligent face-tracking during a video meeting. Easily manage audio and video calls through intuitive controls on your headset, ConferenceCam, Speakerphone or through the webcam software.</p>
                                    <p>Logitech helps unleash Lync productivity and collaboration – from the desktop to the conference room – with intuitive designs that are good for people and good for business.</p>"
				},
				new Sponsor(){
					Name = "Modality",
					ImageName = "modality",
					URL = "http://www.modalitysystems.com",
					Description = @"<p>Modality Systems is a specialist provider of Unified Communications (UC) services, associated products and custom development software for Microsoft Lync. Combining in depth technical expertise with a professional consulting approach, we have an enviable track record in delivering successful projects globally, working with clients to optimise their investment and the value of UC.</p><p>Modality offers a range of end-to-end services from strategic consultancy and design, to deployment, end-user adoption and application development. Our consultants are some of the highest qualified in the Lync world, authoring leading Lync publications and carrying out Lync consultancy projects on behalf of Microsoft.</p>"
				}, 
				new Sponsor(){
					Name = "SMART",
					ImageName = "smart",
					URL = "http://smarttech.com/smartroom ",
					Description = @"<p>SMART Technologies Inc. is a leading provider of technology solutions that enable inspired collaboration in schools and workplaces around the world by turning group work into a highly interactive, engaging and productive experience. SMART delivers an integrated solution of hardware, software and services designed for superior performance and ease of use, and remains a world leader in interactive displays.</p>"
				}, 
				new Sponsor(){
					Name = "Spectralink",
					ImageName = "spectralink",
					URL = "http://www.spectralink.com",
					Description = @"<p>Spectralink, a global leader in wireless solutions, solves the everyday problems of mobile workers through technology, innovation and integration that enable them to do their jobs better. By constantly listening to how customers move through their workdays, Spectralink is able to develop reliable, enterprise-grade voice and data solutions and deliver them through a powerful, durable device. For more information, please visit <a href='http://www.spectralink.com' target='_blank'>www.spectralink.com</a> or call +1 303-441-7500.</p>"
				}, 
				new Sponsor(){
					Name = "Technology Solutions Group",
					ImageName = "tsg",
					URL = "http://www.4tsg.com/lync/",
					Description = @"<p>Technology Solutions Group (TSG) is a world-class communications technology integrator. As a wholly owned subsidiary of TeleTech, TSG specializes in customer experience technology platforms, designing and implementing custom communications solutions for business enterprises of all sizes. Partnering with premier industry manufacturers, TSG blends the best of existing and emerging technologies to address its customers' business needs and imperatives. TSG's solutions help companies elevate the customer experience, enhance efficiencies, increase customer satisfaction and sharpen competitive edge.</p><p>TSG delivers solutions that continually grow and evolve with customers' needs in the ever-changing communications world. Delivering customer experience excellence distinguishes TSG in the marketplace.</p>"
				}, 
				new Sponsor(){
					Name = "UC Point",
					ImageName = "UCPoint",
					URL = "http://www.uc-point.com/en",
					Description = @"<p>UC Point as a Global Microsoft Lync Certified Support Partner is offering 24/7 Premier Lync Support worldwide including 24/7 monitoring and disaster recovery of all major Lync Gateways and Session Border Controllers.</p>
                                    <p>Holding a Microsoft Gold Communications Competency and leveraging two support centers located in Europe and the USA, UC Point was the first certified company worldwide to offer intercontinental Lync Premier Support, thereby covering several time zones.</p>
                                    <p>Exclusively focusing on Lync support and not acting as a systems integrator UC Point is able to offer outsourcing Premier Lync Support to partners.</p>"
				},
				new Sponsor(){
					Name = "Verba Technologies",
					ImageName = "verba",
					URL = "http://www.verba.com/microsoft-lync-call-recording",
					Description = @"<p>Verba Technologies is a leading provider of complete collaboration recording  and quality management solutions for Microsoft Lync with integrated Instant Messaging, Voice, Video and Screen Recording in a single unified platform.  The Verba Recording System provides an open and flexible software-only approach to help companies stay compliant and improve quality. Deployed at leading financial institutions, security companies and contact centers, Verba solutions help organizations better manage risk and compliance, develop quality assurance and increase productivity to enhance their business.</p>"
				}, 
				new Sponsor(){
					Name = "The Via Group",
					ImageName = "via",
					URL = "http://www.theviagroup.com",
					Description = @"<p>The Via Group is a globally recognized leader in providing professional services supporting Unified Communication solutions. As a Gold Certified Partner for Microsoft, Via is a premier provider of communications solutions that span the full range of new and established technologies.  These solutions include voice, video, instant messaging (IM), presence, voice messaging, conference and collaboration. The complete Discovery/Design/Install/Support package from The Via Group includes initial consultation sessions with Senior Engineers, system design, project management, system installation/integration, administrator and Help Desk knowledge transfer, First Day of Services support, and ongoing support services.</p>"
				},
				new Sponsor(){
					Name = "Zeacom",
					ImageName = "Zeacom",
					URL = "http://www.zeacom.com/nz-parent-menu-solutions/partner-platforms/microsoft",
					Description = @"<p>Zeacom, an Enghouse Interactive company, is a leader in communications solutions delivering Multi-Channel Contact Center and Business Process Automation functionality. Established in 1994, today more than 4,000 sites rely on Zeacom’s enterprise-quality solutions to improve the customer experience, increase productivity and understand their communications workflows.</p>
                                    <p>Zeacom Communications Center for Lync enables contact centers, help desks and customer service centers to efficiently manage large numbers of inquiries by phone, email, chat or SMS, and increase productivity by automating repetitive business processes.</p>
                                    <p>Zeacom is a member of the Microsoft Partner Network with Gold competencies in Application Development, Application Integration and Communications.</p>"
				}
			};
			List<Sponsor> eveningSponsors = new List<Sponsor>(){ 
				new Sponsor(){
					Name = "Perficient",
					ImageName = "perficient",
					URL = "http://www.perficient.com/",
					Description = @"<p>Perficient is a leading information technology consulting firm with nearly 2000 technology and business consultants. The company has office locations in major markets across North America with global delivery 
                                    capabilities in China, India and Eastern Europe. Perficient was most recently recognized by Microsoft as 2013 US Partner of the Year, Central Region Cloud Partner of the Year and East Region NSI Partner of the Year. 
                                    Perficient was also named Microsoft Health Provider Partner of the Year three out of the last four years. These awards highlight Perficient’s expertise in  
                                    <a href='http://sharepointconference.com/conference/sponsors' target='_blank'>SharePoint</a>, Office 365, Azure, Lync, Yammer, SQL and Dynamics CRM <a target='_blank' href='http://www.perficient.com/'>www.perficient.com</a>.</p>"
				}
            };
			List<Sponsor> welcomeSponsors = new List<Sponsor>(){                
				new Sponsor(){
					Name = "ScanSource",
					ImageName = "scansource",
					URL = "http://www.scansourcecommunications.com",
					Description = @"<p>ScanSource Communications is a value-added distributor of total communications solutions, including video and audio conferencing products; telephony solutions, including Voice over IP (VoIP); and computer telephony building blocks. ScanSource Communications delivers the industry-leading video conferencing and telephony products and high-quality communications products and services resellers rely on. What's more, resellers have access to exceptional sales and technical support consultation, industry-leading education and training opportunities, custom configuration services, marketing support, and much more. ScanSource Communications is a sales unit of international specialty technology distributor, ScanSource, Inc.</p>"
				}
			};
			List<Sponsor> bronzeSponsors = new List<Sponsor>(){
				new Sponsor(){
					Name = "Arkadin",
					ImageName = "Arkadin",
					URL = "http://www.arkadin.com/",
					Description = @"<p>Founded in 2001, Arkadin is one of the largest and fastest growing collaboration service providers in the world. Arkadin offers a complete range of remote audio, web, and video conferencing and Unified Communications solutions. The services are delivered in the SaaS model for fast, scalable deployments and a high ROI. Its global network of 51 operating centers in 32 countries has dedicated local-language support teams to service its 37,000 customers. Arkadin's Channel Partner Program features white-label and wholesale collaboration for Telcos, service providers, resellers and agents. For more information, please visit <a target='_blank' href='http://www.arkadin.com/'>www.arkadin.com/</a>.</p>"
				},
				new Sponsor(){
					Name = "Avtex",
					ImageName = "avtex",
					URL = "http://www.avtex.com/services/uc-support-services",
					Description = @"<p>Avtex is a technology know-how driven company focused on providing solutions that optimize the many points of interaction that our clients have with their customers, employees, partners and prospects.</p>"
				}, 
				new Sponsor(){
					Name = "Blynclight",
					ImageName = "Blync",
					URL = "http://www.blynclight.com/",
					Description = @"<p>Blync synchronizes with your Lync status to display your availability to those in your environment. This allows your colleagues to see that you are busy on the phone or are not to be disturbed when trying to meet a deadline.</p>"
				},
				new Sponsor(){
					Name = "Bressner Technology",
					ImageName = "bressner",
					URL = "http://www.bressner.com",
					Description = @"<p>Bressner Technology develops Add-ons and Appliances for Microsoft Lync. solutions includes: FonComfort, Complete Call Handling Suite for Lync: call pickup, BusyOnBusy, manager/assistant functions, quicker call transfer, SimulRing, PresenceSync, Hot-Keys and much more to enhance usability and efficiency. QuickLink, 1-Click Call Handling and Live Tile Presence Overview dashboard improves call handling for assistants and teams. UCFeatureBox, Designed specifically for Lync, this multifunctional gateway for VoIP and Fax connects Lync, Exchange, legacy and SIP telephony equipment to deliver functionality well beyond that of traditional VoIP-Gateways.</p>"
				}, 
				new Sponsor(){
					Name = "Brocade",
					ImageName = "Brocade",
					URL = "http://www.brocade.com/",
					Description = @"<p>Brocade leads the industry in providing comprehensive network solutions that help the world’s leading organizations transition smoothly to a virtualized world where applications and information reside anywhere.</p>
                                    <p>As a result, Brocade facilitates strategic business objectives such as consolidation, network convergence, virtualization, and cloud computing. Today, Brocade solutions are used in over 90 percent of Global 1000 data centers as well as in enterprise LANs and the largest service provider networks.</p>"
				},
				new Sponsor(){
					Name = "C4B Com For Business AG",
					ImageName = "c4b",
					URL = "http://www.c4b.com/lync",
					Description = @"<p>With over a million installed licenses, C4B Com For Business AG is a market leader in CTI and Unified Communications software. C4B develops and distributes communications solutions under the XPhone brand for companies of all sizes in all industries. With services such as voice, fax, CTI, presence, desktop sharing and instant messaging and solutions for mobile workers, C4B software improves how businesses interact with customers over the long term while simultaneously streamlining in-house communications processes. Its solutions are distributed by an extensive network of qualified partners, including such major vendors as Siemens, Deutsche Telekom and Swisscom.</p>"
				}, 
				new Sponsor(){
					Name = "Carousel Industries",
					ImageName = "carousel",
					URL = "http://www.carouselindustries.com",
					Description = @"<p>Carousel Industries consults, integrates and manages technology solutions that solve business problems and contribute to your organizations' growth.  Our unified communications, virtualization, Voice over IP (VoIP), visual communications and collaboration and data infrastructure solutions leverage our consultative approach, deep technical expertise, and extensive industry partnerships.</p>"
				}, 
				new Sponsor(){
					Name = "colima communications GmbH",
					ImageName = "colima",
					URL = "http://www.colima.de",
					Description = @"<p>colima manufactures particularly easy to use software products - especially for Microsoft Lync. Building on nearly 15 years experience in the market for Automatic Call Distributors (ACDs) colima  offers high-quality, modular products for professional communication channels.</p>"
				}, 
				new Sponsor(){
					Name = "Competella",
					ImageName = "competella",
					URL = "http://www.competella.com",
					Description = @"<p>Competella AB develops SW-applications within the Multimedia and Unified Communication field based on Microsoft Lync.</p><p>The Competella Unified Communication Suite provides complementary applications for Microsoft Lync that includes an advanced attendant console, a contact center, a voice agent for availability management and a gateway that adds presence status in Microsoft Lync on mobile phones.</p><p>The Suite is also designed to support mixed voice environment with legacy PBX's.</p>"
				}, 
				new Sponsor(){
					Name = "Connexon Telecom Inc.",
					ImageName = "911",
					URL = "http://www.911enable.com",
					Description = @"<p>911 Enable is the industry-leading provider of E911 solutions for VoIP and UC. Its solutions help organizations meet E911 regulations and improve user safety, with automatic IP phone tracking, E911 call routing and on-site security notification features. Together, these innovative offerings represent the industry's only end-to-end E911 solution for IP telephony.</p>"
				},
				new Sponsor(){
					Name = "ExtraTeam",
					ImageName = "extraTeam",
					URL = "http://www.extrateam.com",
					Description = @"<p>Microsoft Systems Integration partner specializing in Unified Communications and Collaboration.</p>"
				},
				new Sponsor(){
					Name = "Insource Technology",
					ImageName = "insourceTech",
					URL = "http://www.insource.com/",
					Description = @"<p>Insource Technology was established in 1992 by the founders of Compaq Computers; they had a simple goal: build the best solutions possible for their clients.  Insource is an IT consulting company headquartered in Houston, TX that provides a wide range of IT services: Enterprise Wireless, Enterprise Applications, Enterprise Infrastructure, Cloud, and Managed Services. One of Insource's best-known products is the Insource Virtual Assistant (iVA), a touch screen monitor that integrates with Lync and serves as a receptionist in empty lobbies.</p>"
				},
				new Sponsor(){
					Name = "Kemp Technologies",
					ImageName = "kemp",
					URL = "http://kemptechnologies.com/service/mslyncinfo",
					Description = @"<p>Since 2000, with over 15,000 worldwide clients and offices in America, Europe, Asia and South America, KEMP Technologies has been a leader in driving the price/performance value proposition for load balancers and application delivery controllers to levels that our customers can afford.</p>"
				}, 
				new Sponsor(){
					Name = "Level 3",
					ImageName = "level3",
					URL = "http://www1.level3.com/index.cfm?pageID=728&cid=AEMPRODISC063010_MSLW1",
					Description = @"<p>Level 3 Communications is a premier global provider of state-of-the-art data, voice, video and managed solutions, serving enterprise, content, government and wholesale customers.  With our highly reliable and secure network, we enable stronger connections around the globe by delivering integrated IP solutions that address customers’ needs for scalability, flexibility and efficiency.  Leveraging our expansive metro footprint and global reach, our team of dedicated people exemplifies our commitment to partnership.  We focus on understanding customers’ business challenges, building relevant worldwide network solutions, and delivering a seamless, industry-leading customer experience.</p>"
				},
				new Sponsor(){
					Name = "MindLink Software",
					ImageName = "mindlink",
					URL = "http://www.mindlinksoft.com",
					Description = @"<p>MindLink Software's Business Critical Collaboration platform, allows real-time collaboration across the business improving team efficiency & productivity. Leveraging Microsoft Lync™, it provides IM, Presence and unique Persistent Chat functionality while being fully integrated into existing processes & systems incl. Sharepoint. MindLink is available on Windows, Mac and Linux and accessible via Web, Desktop, Tablets and Mobile devices. Secure, structured, compliant, MindLink offers unique features & functionalities to enhance collaboration & knowledge sharing.</p>"
				}, 
				new Sponsor(){
					Name = "Mitel",
					ImageName = "mitel",
					URL = "http://www.mitel.com",
					Description = @"<p>Mitel&reg; is a leading global provider of cloud and premises-based business communications and collaboration software and services.  MiContact Center for Microsoft Lync is an end-to-end Lync solution built natively on the Lync Server call control and Lync desktop client, and is recognized by Microsoft as a Lync Qualified Contact Center Application. Mitel has deployed contact center solutions to over 8,000 customers in over 70 countries worldwide.</p>"
				},
				new Sponsor(){
					Name = "Nectar Services Corp.",
					ImageName = "nectar",
					URL = "http://www.nectarcorp.com",
					Description = @"<p>Nectar Converged Monitoring Platform (CMP) is a market leading software solution that provides critical performance information to help align your IT initiatives and business objectives, free up resources, and transform your business infrastructure.</p>"
				}, 
				new Sponsor(){
					Name = "Novus, LLC",
					ImageName = "novus",
					URL = "http://www.novusllc.com",
					Description = @"<p>Novus' comprehensive portfolio of products and services spans the spectrum of traditional PBX communications equipment to cutting edge Unified Communications technologies. When deploying Microsoft Lync, Novus has a unique skill set unrivaled by our competitors. We have the unique ability to offer the broadest spectrum of Lync-specific products at highly competitive prices while providing the level of customer service one would expect at a fine boutique. In fact, Novus is the premier boutique value-added distributor.  Novus has been providing industry leading products and technical services to companies for more than 30-years.</p>"
				}, 
				new Sponsor(){
					Name = "Numonix",
					ImageName = "numonix",
					URL = "http://www.numonix.co/microsoft-lync-call-recording.aspx",
					Description = @"<p>Numonix designs, develops and markets advanced Call Recording and Quality Management Software Solutions to small, medium and Enterprise size business through a network of Authorized Resellers and Distributors throughout the world. Our products are deployed globally in Contact Center, Financial, Customer Service and Compliance Oriented businesses. Our flagship product, Clarity, provides an innovative, cost-effective product that includes call recording, quality management, screen capture and agent scoring. MediaLog's software architecture is designed from our vast industry experience and is based on Microsoft Silverlight technology, which makes Clarity flexible and customizable for specific customer environments.</p>"
				},
				new Sponsor(){
					Name = "Oracle",
					ImageName = "oracle",
					URL = "http://www.oracle.com/communications",
					Description = @"<p>Oracle Communications solutions span the communications industry landscape -- from cross-channel customer experience and business and operational support systems, to network service and session delivery and control solutions -- enabling service providers and enterprises to deliver and monetize innovative digital lifestyle services, build strong customer relationships, and streamline operations.</p>"
				},
				new Sponsor(){
					Name = "Sangoma Technologies",
					ImageName = "sangoma",
					URL = "http://www.sangoma.com/products/netborder-lync-express/",
					Description = @"<p>Sangoma is a leading provider of hardware and software that enable or enhance IP Communications Systems. Enterprises, SMBs and Carriers in over 150 countries rely on Sangoma's VoIP Gateways, Telephony Interface Boards and SBCs as part of their mission critical infrastructures. Sangoma delivers the industry's best engineered, highest quality products at prices that enhance customers' bottom line and ROI. Visit the Sangoma NetBorder Lync Express solutions page to learn more.</p>"
				}, 
				new Sponsor(){
					Name = "SoTel Systems, LLC",
					ImageName = "sotel",
					URL = "http://www.sotelsystems.com/business-voip/microsoft-lync",
					Description = @"<p>We are a distributor of new and refurbished telecommunications hardware, and are a &quot;Lync in a Box&quot; distributor.  We are also a nationwide SIP trunking provider, and are certified on Lync 2013.</p>"
				},
				new Sponsor(){
					Name = "TE Systems",
					ImageName = "TE-Systems",
					URL = "http://www.te-systems.de/lync",
					Description = @"<p>TE-SYSTEMS was established in 1990, we have been specializing in the development of software for VoIP. Our latest development is ANYNODE - a software solution that works as an SBC for Microsoft Lync.</p>"
				},
 				new Sponsor(){
					Name = "Telecommunications",
					ImageName = "samroxx",
					URL = "http://www.samroxx.com/",
					Description = @"<p>The company telecommunication software gmbh is an extremely innovative software company and just released its newest attendant console product samroxx.  samroxx is an extremely innovative, plug and play enterprise software solution.</p>"
				},
				new Sponsor(){
					Name = "Verapresence",
					ImageName = "Verapresence",
					URL = "http://www.verapresence.com/",
					Description = @"<p>Verapresence creates applications that bring essential feature functionality found in popular communications platforms to the Microsoft Unified Communications ecosystem.</p>"
				}
			};
			
			List<Level> levels = new List<Level>
			{
				new Level("Diamond Sponsor", "diamond", diamondSponsors),
				new Level("Platinum Sponsors", "platinum", platinumSponsors),
				new Level("Gold Sponsors", "gold", goldSponsors),
				new Level("Silver Sponsors", "silver", silverSponsors),
  				new Level("Bronze Sponsors", "bronze", bronzeSponsors),
                new Level("Evening Event Sponsor", "evening", eveningSponsors),
				new Level("Welcome Reception Sponsor", "welcomeReception", welcomeSponsors)
			};
		%>
		<% foreach (var level in levels){ %>
			<article class="heading <%= level.Class %>">
                <%= level.Name %>
                <a class="plusMinus" data-level="<%= level.Class %>"></a>
			</article>
				<section class="sponsors <%= level.Class %>">
					<%
                    int i = 0;
					foreach (var Sponsor in level.Sponsors) {
                        i++;
					%>
					    <section class="sponsor">
						    <span>
                               <% // Naming convention  for images  as follows size 230x230 for square type logos 230x60 for all others example: perficient.jpg and small size image is 230x60 perficient_min.png %> 
								<a href="<%= Sponsor.URL %>" target="_blank"><img src="/Images/Sponsors/minimized/<%= Sponsor.ImageName %>_min.png" /><img src="/Images/Sponsors/<%= Sponsor.ImageName %>.jpg"/></a>
							</span>
						    <article class="description">
							    <h4><%= Sponsor.Name %></h4>
							    <%= Sponsor.Description %>
							    <a href="<%= Sponsor.URL %>" target="_blank" class="websiteButton">Visit Website &gt;</a>
						    </article>
						    <section class="clearfix"></section>
					    </section>
					<% 
                        if ((i % 4) == 0)
                        {
                            %> <div class="clearfix"></div> <%
                        }
                    } 
                    %>
                    <section class="clearfix"></section>
				</section>
		<% } %>
	</section>
</asp:Content>

<asp:Content ID="CSS" runat="server" ContentPlaceHolderID="CSSContent"></asp:Content>

<asp:Content ID="JS" runat="server" ContentPlaceHolderID="JSContent">
	<script type="text/javascript">
	    $(document).ready(function () {
	        $("#sponsors-nav").addClass("active");
	    });
	</script>
</asp:Content>
	  