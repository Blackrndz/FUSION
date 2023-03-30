/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Configure%20Enrollment%20Action%20Items%20-%20Configure%20Enrollment%20Action%20Items.sql $:
 * $Id: Configure Enrollment Action Items - Configure Enrollment Action Items.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT benACTNTYPEO.TYPE_CD RES_ACTION_TYPE
,benACTNTYPEO.NAME RES_ACTION_ITEM
,benACTNTYPEO.DESCRIPTION RES_DESCRIPTION
,benACTNTYPEO.LAST_UPDATED_BY 			RSC_LAST_UPDATED_BY
,benACTNTYPEO.LAST_UPDATE_DATE 			RSC_LAST_UPDATE_DATE
,benACTNTYPEO.CREATED_BY 				RSC_CREATED_BY
,benACTNTYPEO.CREATION_DATE 			RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_ACTN_TYP_VL benACTNTYPEO
