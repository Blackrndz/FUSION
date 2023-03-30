/* ****************************************************************************
 * $Revision: 80142 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2023-02-10 15:40:25 +0700 (Fri, 10 Feb 2023) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Procurement%20Agents%20-%20Agent%20Access.sql $:
 * $Id: Manage Procurement Agents - Agent Access.sql 80142 2023-02-10 08:40:25Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT HEAD.BU_NAME RES_PROCUREMENT_BU
,HEAD.LIST_NAME RES_AGENT_NAME
,HEAD.AGENT_E_MAIL RES_AGENT_E_MAIL
,Detail.DISPLAYED_FIELD RES_ACTION
,DECODE(Detail.ALLOWED_FLAG,'Y','Yes','No') RES_ALLOWED
,decode(Detail.ACCESS_OTHERS_LEVEL_CODE,null,'Not Applicable',Detail.ACCESS_OTHERS_LEVEL_CODE) RES_ACCESS_TO_OTHER_AGENTS_DOC
,Detail.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,Detail.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,Detail.CREATED_BY  RSC_CREATED_BY
,Detail.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,Detail.PRC_BU_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT distinct ASSIGNMENT_ID
	,PrcBuPEO.BU_NAME
	,PersonNameDPEO.LIST_NAME
	,(SELECT distinct email_address
		FROM Fusion.PER_EMAIL_ADDRESSES
		WHERE person_id = PersonNameDPEO.PERSON_ID
		and MASTERED_IN_LDAP_FLAG = 'Y'
		AND ROWNUM = 1
		) AGENT_E_MAIL
	FROM Fusion.PO_AGENT_ASSIGNMENTS AgentAssignmentEO
	,Fusion.FUN_BU_USAGES_V PrcBuPEO
	,Fusion.FUN_BU_USAGES_V ReqBuPEO
	,Fusion.PER_PERSON_NAMES_F_V PersonNameDPEO
	WHERE(((AgentAssignmentEO.PRC_BU_ID     = PrcBuPEO.BUSINESS_UNIT_ID
	AND PrcBuPEO.MODULE_KEY                 = 'PROCUREMENT_BF')
	AND(AgentAssignmentEO.DEFAULT_REQ_BU_ID = ReqBuPEO.BUSINESS_UNIT_ID(+)
	AND ReqBuPEO.MODULE_KEY(+)              = 'REQUISITIONING_BF'))
	AND(AgentAssignmentEO.AGENT_ID          = PersonNameDPEO.PERSON_ID))
	) HEAD
,(SELECT distinct PrcAgentAccessEO.ASSIGNMENT_ID
	,PrcAgentAccessEO.PRC_BU_ID
	,PrcAgentAccessEO.ALLOWED_FLAG
	,(SELECT distinct PoLookupPEO.DISPLAYED_FIELD
		FROM Fusion.PO_LOOKUP_CODES PoLookupPEO
		WHERE PoLookupPEO.LOOKUP_TYPE = 'PO_AGENT_ACCESS_OTHERS_LEVEL'
		AND PoLookupPEO.LOOKUP_CODE   = PrcAgentAccessEO.ACCESS_OTHERS_LEVEL_CODE
		) ACCESS_OTHERS_LEVEL_CODE
	,PoLookupPEO.DISPLAYED_FIELD
	,PrcAgentAccessEO.LAST_UPDATED_BY
	,PrcAgentAccessEO.LAST_UPDATE_DATE
	,PrcAgentAccessEO.CREATED_BY
	,PrcAgentAccessEO.CREATION_DATE
	FROM Fusion.PO_AGENT_ACCESSES PrcAgentAccessEO
	,Fusion.PO_LOOKUP_CODES PoLookupPEO
	WHERE PrcAgentAccessEO.ACCESS_ACTION_CODE = PoLookupPEO.LOOKUP_CODE(+)
	AND PoLookupPEO.LOOKUP_TYPE(+)            = 'PO_AGENT_ACCESS_ACTION'
	ORDER BY DECODE(PrcAgentAccessEO.ACCESS_ACTION_CODE,'MANAGE_REQUISITIONS',1,'MANAGE_PURCHASE_ORDERS',2,
		'MANAGE_PURCHASE_AGREEMENTS',3,'MANAGE_NEGOTIATIONS',4,'MANAGE_CATALOG_CONTENT',5,'MANAGE_SUPPLIERS',6,
		'MANAGE_QUALIFICATIONS',7,'MANAGE_ASLS',8,'ANALYZE_SPEND',9,NULL)
	) DETAIL
WHERE Head.ASSIGNMENT_ID = Detail.ASSIGNMENT_ID
order by HEAD.BU_NAME,HEAD.LIST_NAME