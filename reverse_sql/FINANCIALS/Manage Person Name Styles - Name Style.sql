/* ****************************************************************************
* $Revision: 59117 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-21 11:10:58 +0700 (Fri, 21 Oct 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Key%20Flexfields%20-%20Segment%20Labels.sql $:
* $Id: Manage Key Flexfields - Segment Labels.sql 59117 2016-10-21 04:10:58Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT nameStylesE0.NAME_STYLE RES_COUNTRY
,DECODE(nameStylesE0.ALTERNATE_NAME_REQUIRED,'Y','Yes','N','No') RES_LOCAL_NAME_REQUIRED
,nameStylesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,nameStylesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,nameStylesE0.CREATED_BY RSC_CREATED_BY
,nameStylesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,nameStylesE0.LEGISLATION_CODE RSC_COUNTRY_ID

FROM PER_NAME_STYLES_VL nameStylesE0
ORDER BY nameStylesE0.NAME_STYLE