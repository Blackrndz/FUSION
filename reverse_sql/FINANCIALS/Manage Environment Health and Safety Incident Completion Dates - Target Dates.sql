/* ****************************************************************************
 * $Revision: 73433 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2020-02-03 13:41:32 +0700 (Mon, 03 Feb 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Configure%20Recruiting%20Interaction%20Categories%20-%20Lookup%20Types.sql $:
 * $Id: Configure Recruiting Interaction Categories - Lookup Types.sql 73433 2020-02-03 06:41:32Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=HNS_CONFIG_VL
 
WITH ACTION_APPROVAL_DATE AS (SELECT CONFIG_VALUE
							,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE
							FROM HNS_CONFIG_VL WHERE CONFIG_TYPE = 'ORA_HNS_TARGET_DATES'
							AND CONFIG_CODE = 'ORA_ACTION_TARGET_APPROVE_DATE')
,ACTION_COMPLETION_DATE AS (SELECT CONFIG_VALUE FROM HNS_CONFIG_VL WHERE CONFIG_TYPE = 'ORA_HNS_TARGET_DATES'
							AND CONFIG_CODE = 'ORA_ACTION_TARGET_COMPLN_DATE')
,ACTION_REVIEW_DATE AS (SELECT CONFIG_VALUE FROM HNS_CONFIG_VL WHERE CONFIG_TYPE = 'ORA_HNS_TARGET_DATES'
							AND CONFIG_CODE = 'ORA_ACTION_TARGET_REVIEW_DATE')
,ACTION_PREAPP_DATE AS (SELECT CONFIG_VALUE FROM HNS_CONFIG_VL WHERE CONFIG_TYPE = 'ORA_HNS_TARGET_DATES'
							AND CONFIG_CODE = 'ORA_ACT_PREAPRV_TRGT_COMPLN_DT')
,INCIDENT_EVENT_DATE AS (SELECT CONFIG_VALUE FROM HNS_CONFIG_VL WHERE CONFIG_TYPE = 'ORA_HNS_TARGET_DATES'
							AND CONFIG_CODE = 'ORA_EVNT_TARGET_COMPLN_DATE')
,INCIDENT_TARGET_APP_DATE AS (SELECT CONFIG_VALUE  FROM HNS_CONFIG_VL WHERE CONFIG_TYPE = 'ORA_HNS_TARGET_DATES'
							AND CONFIG_CODE = 'ORA_INCID_TARGET_APPROVAL_DATE')
,INCIDENT_TARGET_COMP_DATE AS (SELECT CONFIG_VALUE FROM HNS_CONFIG_VL WHERE CONFIG_TYPE = 'ORA_HNS_TARGET_DATES'
							AND CONFIG_CODE = 'ORA_INCID_TARGET_COMPLN_DATE')
,INCIDENT_TARGET_REV_DATE AS (SELECT CONFIG_VALUE FROM HNS_CONFIG_VL WHERE CONFIG_TYPE = 'ORA_HNS_TARGET_DATES'
							AND CONFIG_CODE = 'ORA_INCID_TARGET_REVIEW_DATE')
,INV_TARGET_APP_DATE AS (SELECT CONFIG_VALUE FROM HNS_CONFIG_VL WHERE CONFIG_TYPE = 'ORA_HNS_TARGET_DATES'
							AND CONFIG_CODE = 'ORA_INVEST_TARGET_APPR_DATE')
,INV_TARGET_COMP_DATE AS (SELECT CONFIG_VALUE FROM HNS_CONFIG_VL WHERE CONFIG_TYPE = 'ORA_HNS_TARGET_DATES'
							AND CONFIG_CODE = 'ORA_INVEST_TARGET_COMPLN_DATE')
,INV_TARGET_REVEIW_DATE AS (SELECT CONFIG_VALUE FROM HNS_CONFIG_VL WHERE CONFIG_TYPE = 'ORA_HNS_TARGET_DATES'
							AND CONFIG_CODE = 'ORA_INVEST_TARGET_REVIEW_DATE')
,INV_TARGET_PREAPP_DATE AS (SELECT CONFIG_VALUE FROM HNS_CONFIG_VL WHERE CONFIG_TYPE = 'ORA_HNS_TARGET_DATES'
							AND CONFIG_CODE = 'ORA_INV_PREAPRV_TRGT_COMPLN_DT')
 

SELECT ACTION_APPROVAL_DATE.CONFIG_VALUE RES_ACTION_TARGET_APPROVAL_DAT
,ACTION_COMPLETION_DATE.CONFIG_VALUE RES_ACTION_TARGET_COMPLETION_D
,ACTION_REVIEW_DATE.CONFIG_VALUE RES_ACTION_TARGET_REVIEW_DATE
,ACTION_PREAPP_DATE.CONFIG_VALUE RES_ACTION_TARGET_PREAPPROVAL_
,INCIDENT_EVENT_DATE.CONFIG_VALUE RES_INCIDENT_EVENT_TARGET_COMP
,INCIDENT_TARGET_APP_DATE.CONFIG_VALUE RES_INCIDENT_TARGET_APPROVAL_D
,INCIDENT_TARGET_COMP_DATE.CONFIG_VALUE RES_INCIDENT_TARGET_COMPLETION
,INCIDENT_TARGET_REV_DATE.CONFIG_VALUE RES_INCIDENT_TARGET_REVIEW_DAT
,INV_TARGET_APP_DATE.CONFIG_VALUE RES_INVESTIGATION_TARGET_APPRO
,INV_TARGET_COMP_DATE.CONFIG_VALUE RES_INVESTIGATION_TARGET_COMPL
,INV_TARGET_REVEIW_DATE.CONFIG_VALUE RES_INVESTIGATION_TARGET_REVIE
,INV_TARGET_PREAPP_DATE.CONFIG_VALUE RES_INVESTIGATION_TARGET_PREAP

,ACTION_APPROVAL_DATE.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ACTION_APPROVAL_DATE.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ACTION_APPROVAL_DATE.CREATED_BY RSC_CREATED_BY
,ACTION_APPROVAL_DATE.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ACTION_APPROVAL_DATE
,ACTION_COMPLETION_DATE
,ACTION_REVIEW_DATE
,ACTION_PREAPP_DATE
,INCIDENT_EVENT_DATE
,INCIDENT_TARGET_APP_DATE
,INCIDENT_TARGET_COMP_DATE
,INCIDENT_TARGET_REV_DATE
,INV_TARGET_APP_DATE
,INV_TARGET_COMP_DATE
,INV_TARGET_REVEIW_DATE
,INV_TARGET_PREAPP_DATE