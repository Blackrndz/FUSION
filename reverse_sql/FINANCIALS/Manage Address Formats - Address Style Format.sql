/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Address%20Formats%20-%20Address%20Style%20Format.sql $:
 * $Id: Manage Address Formats - Address Style Format.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT hzStyleFormatEO.STYLE_FORMAT_CODE RES_CODE
 ,hzStyleFormatEO.STYLE_FORMAT_NAME RES_NAME
 ,(SELECT STYLE_NAME FROM HZ_STYLES_VL
	WHERE STYLE_CODE = hzStyleFormatEO.STYLE_CODE 
	)RES_ADDRESS_STYLE
 ,hzStyleFormatEO.DESCRIPTION RES_DESCRIPTION
 ,DECODE(hzStyleFormatEO.DEFAULT_FLAG,'Y','Yes','No') RES_DEFAULT_FORMAT_FOR_STYLE
 ,hzStyleFormatEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
 ,hzStyleFormatEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
 ,hzStyleFormatEO.CREATED_BY RSC_CREATED_BY
 ,hzStyleFormatEO.CREATION_DATE RSC_CREATION_DATE
 ,NULL RSC_LEDGER_ID
 ,NULL RSC_CHART_OF_ACCOUNTS_ID
 ,NULL RSC_BUSINESS_UNIT_ID
 ,NULL RSC_LEGAL_ENTITY_ID
 ,NULL RSC_ORGANIZATION_ID
 ,NULL RSC_BUSINESS_GROUP_ID
 ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_STYLE_FORMATS_VL hzStyleFormatEO
WHERE hzStyleFormatEO.STYLE_CODE IN ('PARTY_SUFFIX','POSTAL_ADDR','SUPP_TAX_AND_RPTNG_ADDR')
ORDER BY 1


