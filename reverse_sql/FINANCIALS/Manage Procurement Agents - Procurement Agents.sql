/* ****************************************************************************
 * $Revision: 80142 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2023-02-10 15:40:25 +0700 (Fri, 10 Feb 2023) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Procurement%20Agents%20-%20Procurement%20Agents.sql $:
 * $Id: Manage Procurement Agents - Procurement Agents.sql 80142 2023-02-10 08:40:25Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 


SELECT distinct PrcBuPEO.BU_NAME RES_PROCUREMENT_BU
,PersonNameDPEO.LIST_NAME RES_AGENT_NAME
,(SELECT  email_address
	FROM Fusion.PER_EMAIL_ADDRESSES
	WHERE person_id = PersonNameDPEO.PERSON_ID
	and MASTERED_IN_LDAP_FLAG = 'Y'
	AND ROWNUM = 1
	) RES_AGENT_E_MAIL
,ReqBuPEO.BU_NAME RES_DEFAULT_REQUISITIONING_BU
,AgentAssignmentEO.DEFAULT_PRINTER_NAME RES_DEFAULT_PRINTER
,decode(AgentAssignmentEO.ACTIVE_FLAG,'Y','Active','N','Inactive')	 RES_STATUS
,AgentAssignmentEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,AgentAssignmentEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,AgentAssignmentEO.CREATED_BY  RSC_CREATED_BY
,AgentAssignmentEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,AgentAssignmentEO.PRC_BU_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM Fusion.PO_AGENT_ASSIGNMENTS AgentAssignmentEO
,Fusion.FUN_BU_USAGES_V PrcBuPEO
,Fusion.FUN_BU_USAGES_V ReqBuPEO
,Fusion.PER_PERSON_NAMES_F_V PersonNameDPEO
WHERE(((AgentAssignmentEO.PRC_BU_ID     = PrcBuPEO.BUSINESS_UNIT_ID
AND PrcBuPEO.MODULE_KEY                 = 'PROCUREMENT_BF')
AND(AgentAssignmentEO.DEFAULT_REQ_BU_ID = ReqBuPEO.BUSINESS_UNIT_ID(+)
AND ReqBuPEO.MODULE_KEY(+)              = 'REQUISITIONING_BF'))
AND(AgentAssignmentEO.AGENT_ID          = PersonNameDPEO.PERSON_ID))
ORDER BY PrcBuPEO.BU_NAME
,PersonNameDPEO.LIST_NAME ASC
